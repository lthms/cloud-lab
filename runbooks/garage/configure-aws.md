# Configure `aws` against garage

Garage speaks S3. Use `aws` CLI to interact with it.

## Read the credentials

They live encrypted in `garage/secret.yaml`. `sops` can extract one value at a
time, without ever writing the plaintext file to disk:

```bash
sops -d --extract '["stringData"]["s3-access-key"]' garage/secret.yaml
sops -d --extract '["stringData"]["s3-secret-key"]' garage/secret.yaml
```

## Write the profile

Two files, as the `aws` CLI splits credentials from everything else.

In `~/.aws/credentials`:

```ini
[garage]
aws_access_key_id = <s3-access-key>
aws_secret_access_key = <s3-secret-key>
```

In `~/.aws/config`:

```ini
[profile garage]
region = garage
endpoint_url = https://s3.xmu.mx
s3 =
    addressing_style = path
```

`addressing_style = path` is not optional. Left to itself the CLI addresses a
bucket as `<bucket>.s3.xmu.mx`, and every call would fail to resolve. `region =
garage` matches `s3_region` in `garage/garage.toml`.

## Check

```bash
aws --profile garage s3 ls
```

An empty answer with exit code 0 means the endpoint, the credentials and the
signature all line up. `InvalidAccessKeyId` means the key was never imported.
In that case, look at the `garage-bootstrap` Job.

