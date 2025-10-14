Secrets required for CI / Deployment
===================================

This project deploys to EKS using GitHub Actions. To avoid storing sensitive values in the
repository, the CI expects several repository secrets / variables to be configured.

Please add the following **Repository secrets** (Settings → Secrets and variables → Actions):

- DB_USER: the database username used by the application (example: demo_user)
- DB_PASS: the database password used by the application (example: S3cureP@ss)
- DOCKERHUB_USERNAME: Docker Hub username where the image will be pushed
- DOCKERHUB_TOKEN: Docker Hub access token / password (scoped token)
- AWS_OIDC_ROLE_ARN: The IAM role ARN that GitHub Actions will assume via OIDC to access AWS

Additionally, add these **Repository variables** (Settings → Actions → Variables) or replace with your preferred method:
- AWS_REGION: the AWS region e.g. ap-south-1

How the workflow uses these values
- `kubernetes-deploy.yml` will build and push the Docker image using `DOCKERHUB_USERNAME`/`DOCKERHUB_TOKEN`.
- The workflow assumes an OIDC role is available via `AWS_OIDC_ROLE_ARN` to authenticate to AWS and update kubeconfig.
- Before applying manifests, the workflow will create the `app-secret` Kubernetes Secret from `DB_USER` and `DB_PASS` via kubectl.

Exact workflow snippet (already added to `.github/workflows/kubernetes-deploy.yml`):

```yaml
      - name: Create Kubernetes secret from GitHub Secrets
        if: ${{ always() }}
        env:
          DB_USER: ${{ secrets.DB_USER }}
          DB_PASS: ${{ secrets.DB_PASS }}
        run: |
          kubectl create secret generic app-secret \
            --from-literal=DB_USER="$DB_USER" \
            --from-literal=DB_PASS="$DB_PASS" \
            -n default --dry-run=client -o yaml | kubectl apply -f -
```

How to add secrets in GitHub
----------------------------
1. Open your repository on github.com.
2. Settings → Secrets and variables → Actions → New repository secret.
3. Add the key (for example `DB_USER`) and the secret value.

Security notes
- If secrets were already committed, rotate them immediately.
- Consider using AWS Secrets Manager, HashiCorp Vault, or SealedSecrets for production-grade management.
