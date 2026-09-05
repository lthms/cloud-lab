# Create a bucket

Assumes the `garage` profile from [configure-aws.md](configure-aws.md).

## Create it

```bash
aws --profile garage s3 mb s3://example
```

The key that creates a bucket becomes its owner, which is what later allows
changing its website configuration or its permissions.

The name is only a *local* alias though, private to that key. Serving the
bucket over the web needs a *global* one, which the S3 API cannot create; the
`garage-website-aliases` CronJob adds it a few minutes later, but only to
buckets with website mode on — see
[publish-a-bucket-as-a-website.md](publish-a-bucket-as-a-website.md).

## Put something in it

```bash
aws --profile garage s3 cp ./file.txt s3://example/
aws --profile garage s3 sync ./directory s3://example/prefix
aws --profile garage s3 ls s3://example --recursive
```

## Watch the space

Every bucket shares the one 45G the layout advertises, and nothing enforces a
share of it per bucket. `--summarize` adds the object count and total size to
a listing:

```bash
aws --profile garage s3 ls s3://example --recursive --summarize --human-readable
```

## Delete it

A bucket has to be empty first, and the deletion is not reversible.

```bash
aws --profile garage s3 rm s3://example --recursive
aws --profile garage s3 rb s3://example
```

