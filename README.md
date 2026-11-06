# GitHub Actions OIDC Setup for AWS Accounts

This guide explains how to configure GitHub Actions OpenID Connect (OIDC) access to AWS by:

1. Creating the GitHub OIDC Identity Provider in each AWS account.
2. Creating an IAM role with administrative access.
3. Configuring the role trust policy to allow authentication from the GitHub repository `urmilapurohit/github_action`.

---

## Prerequisites

- AWS Account access with IAM administrator privileges
- GitHub repository: `urmilapurohit/github_action`
- AWS CLI installed and configured

---

# Step 1: Create the GitHub OIDC Identity Provider

Create the GitHub Actions identity provider in each AWS account.

## Create via AWS Console

1. Navigate to **IAM**
2. Select **Identity Providers**
3. Click **Add Provider**
4. Choose:
   - Provider Type: **OpenID Connect**
   - Provider URL:

     ```text
     https://token.actions.githubusercontent.com
     ```

   - Audience:

     ```text
     sts.amazonaws.com
     ```

5. Click **Add Provider**

---

# Step 2: Create GitHub Actions IAM Role

Create an IAM role named `GitHubActionsAdminRole` and use the following trust policy.

## Trust Policy

Replace `<ACCOUNT_ID>` with the AWS Account ID where the role is being created.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::<ACCOUNT_ID>:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:urmilapurohit/github_action:*"
        }
      }
    }
  ]
}
```*
---

# Step 3: Attach Administrat*r Access

Attach the AWS managed `*dministratorAccess` policy to the *ole.

## AWS Console

*. Open the role.
2. Select **Add p*rmissions**.
3. Attach policy:
   * `AdministratorAccess`

---

# Ste* 4: Configure GitHub Actions

Crea*e a workflow file under:

```text
*github/workflows/deploy.yml
```

E*ample workflow:

```yaml
name: Dep*oy

on:
  push:
    branches:
    * - main

permissions:
  id-token: *rite
  contents: read

jobs:
  dep*oy:
    runs-on: ubuntu-latest

  * steps:
      - name: Checkout
   *    uses: actions/checkout@v4

   *  - name: Configure AWS Credential*
        uses: aws-actions/configu*e-aws-credentials@v4
        with:*          role-to-assume: arn:aws:*am::<ACCOUNT_ID>:role/GitHubAction*AdminRole
          aws-region: eu*west-1

      - name: Verify Acces*
        run: aws sts get-caller-i*entity
```

---
## Add the IAM role and identity role provider info in workflow
---
# Troubleshooting

## *o OpenIDConnect provider found

Ve*ify the provider exists:

```bash
*ws iam list-open-id-connect-provid*rs
```

## Not authorized to perfo*m sts:AssumeRoleWithWebIdentity

V*rify:

- Identity Provider exists.*- Role trust policy contains the c*rrect OIDC provider ARN.
- Repository name matches:

```text
repo:urmilapurohit/github_action:*
```

- Workflow permissions include:

```yaml
permissions:
  id-token: write
  contents: read
```

## Invalid identity token

Ensure the workflow is using:

```yaml
uses: aws-actions/configure-aws-credentials@v4
```

and the correct role ARN.

---

# Security Recommendation

For production environments, avoid using `AdministratorAccess`. Instead, create a custom IAM policy that grants only the permissions required by your Terraform deployment pipelines. This follows AWS least-privilege best practices and reduces security risk.
