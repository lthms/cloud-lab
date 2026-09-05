# Publish a bucket as a website

Assumes a bucket, per [create-a-bucket.md](create-a-bucket.md).

The name of a bucket decides how the bucket can be served, and there are two
shapes to choose between:

- a single DNS label like `example` is served under the wildcard at
  `example.pages.xmu.mx` for free.
- a whole domain like `example.org` is served at `example.org`. It needs an
  Ingress and a certificate of its own.

Garage serves static sites on its own port, and picks the bucket from the
`Host` header two ways:

```
Host: example.pages.xmu.mx  ──strip root_domain──▶  bucket alias "example"
Host: example.org           ──no match, use whole──▶  bucket alias "example.org"
```

Three things have to be true, and none implies the others.

## 1. The bucket has a website configuration

Off by default, and it is the whole of "public": objects stay private over the
S3 API — a request there is still signed with the key — while the web port
answers anyone, for this bucket only. There is no ACL or bucket policy to
write.

```bash
aws --profile garage s3 website s3://example \
    --index-document index.html \
    --error-document error.html
```

## 2. The content is there

`aws sync` command is handy to make sure a bucket replicate the content of a
directory on the local filesystem.

```bash
aws --profile garage s3 sync ./site s3://example --delete
```

`--delete` removes objects the local directory no longer has.

## 3. The name is a *global* alias

A bucket created over the S3 API only carries a **local** alias, private to the
key, while the web server resolves a hostname among **global** ones. By
default, the bucket uploads fine, reports website mode on, and still answers
404.

The `garage-website-aliases` CronJob closes that gap every minute: it
gives any website-enabled bucket that lacks a global alias one, named after
its local alias. Until it has run, the 404 is expected.

!!! warning

    The CronJob does not support bucket being renamed with `aws`. If a global
    alias was already assigned, it will never change.

## Under its own domain

Garage matches the whole `Host` when it is not under `root_domain`, and dots
are legal in a bucket name, so a bucket created as `example.org` is served at
`example.org`.

```bash
aws --profile garage s3 mb s3://example.org
```

The cluster also needs to accept that name, which means a dedicated Ingress.

```yaml
spec:
  tls:
    - hosts:
        - example.org
      secretName: garage-example-org-tls
  rules:
    - host: example.org
      # …same backend: service garage, port web
```

external-dns only writes records in the zones it is given
(`--domain-filter`), so a domain raya does not own has to have its own record
pointed at the cluster by hand.

## Check

```bash
curl -I https://example.pages.xmu.mx
```

- `404`: the hostname resolves to no bucket — the global alias is missing, so
  either the CronJob has not run yet or it skipped this bucket (step 3).
- `403`: the bucket is there but website mode is off (step 1), so garage
  answered as the plain S3 endpoint would.
- A certificate error: cert-manager has not issued it yet (`garage-web-tls` or
  for the ad-hoc domain). It should be solved after a few minutes.
