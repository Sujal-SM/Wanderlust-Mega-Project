# GitOps - Continuous Deployment Pipeline 🚀

This folder contains the GitOps implementation for the Wanderlust application, enabling automated deployment through Jenkins CD pipeline.

## 📋 Overview

GitOps is a deployment methodology that uses Git as the single source of truth for declarative infrastructure and applications. This pipeline automatically updates Kubernetes manifests with new Docker image tags and deploys them to the EKS cluster.

## 🏗️ Architecture Flow

```
CI Pipeline (Build) → GitOps Pipeline (Deploy) → ArgoCD → EKS Cluster
```

1. **CI Pipeline** builds and pushes Docker images with new tags
2. **GitOps Pipeline** updates Kubernetes manifests with new image tags
3. **ArgoCD** detects changes and deploys to EKS cluster
4. **Email notifications** sent on success/failure

## 📁 Files Structure

```
GitOps/
├── README.md          # This documentation
└── Jenkinsfile        # CD pipeline definition
```

## 🔧 Pipeline Configuration

### Parameters
- `FRONTEND_DOCKER_TAG`: Frontend Docker image tag from CI pipeline
- `BACKEND_DOCKER_TAG`: Backend Docker image tag from CI pipeline

### Pipeline Stages

| Stage | Description | Actions |
|-------|-------------|---------|
| **Workspace Cleanup** | Clean Jenkins workspace | `cleanWs()` |
| **Git Checkout** | Clone repository | Checkout main branch |
| **Verify Tags** | Display image tags | Echo parameters |
| **Update Manifests** | Update K8s YAML files | Replace image tags using `sed` |
| **Git Push** | Commit and push changes | Push updated manifests |

## 🚀 How It Works

### 1. Trigger Pipeline
The GitOps pipeline is triggered by the CI pipeline with Docker image tags:

```bash
# Example trigger from CI pipeline
build job: 'GitOps-Pipeline', 
parameters: [
    string(name: 'FRONTEND_DOCKER_TAG', value: "${FRONTEND_TAG}"),
    string(name: 'BACKEND_DOCKER_TAG', value: "${BACKEND_TAG}")
]
```

### 2. Manifest Updates
The pipeline updates Kubernetes manifests in the `/kubernetes` directory:

**Backend Update:**
```bash
sed -i -e s/wanderlust-backend-beta.*/wanderlust-backend-beta:${BACKEND_DOCKER_TAG}/g backend.yaml
```

**Frontend Update:**
```bash
sed -i -e s/wanderlust-frontend-beta.*/wanderlust-frontend-beta:${FRONTEND_DOCKER_TAG}/g frontend.yaml
```

### 3. Git Operations
```bash
git add .
git commit -m "Updated environment variables"
git push https://github.com/Sujal-SM/Wanderlust-Mega-Project.git main
```

### 4. ArgoCD Detection
ArgoCD monitors the repository and automatically deploys changes to the EKS cluster.

## 📧 Email Notifications

### Success Notification
- **Subject**: "Wanderlust Application has been updated and deployed - 'SUCCESS'"
- **Content**: Project name, build number, and build URL
- **Styling**: HTML formatted with colored sections

### Failure Notification
- **Subject**: "Wanderlust Application build failed - 'FAILURE'"
- **Content**: Project name and build number
- **Attachment**: Build logs for debugging

## 🔐 Prerequisites

### Jenkins Configuration
1. **Shared Library**: `@Library('Shared')` must be configured
2. **Node Label**: Jenkins agent with label `'Node'`
3. **Credentials**: 
   - `Github-cred`: Git username/password credentials
   - Email configuration for notifications

### Required Tools on Jenkins Agent
- Git
- sed (for text replacement)

## 🎯 Usage Instructions

### 1. Setup Jenkins Job
```groovy
// Create a new Pipeline job in Jenkins
// Use this Jenkinsfile from SCM
// Configure parameters: FRONTEND_DOCKER_TAG, BACKEND_DOCKER_TAG
```

### 2. Configure ArgoCD Application
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: wanderlust-app
spec:
  source:
    repoURL: https://github.com/Sujal-SM/Wanderlust-Mega-Project.git
    path: kubernetes
    targetRevision: main
  destination:
    server: https://kubernetes.default.svc
    namespace: wanderlust
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

### 3. Trigger from CI Pipeline
```groovy
// In your CI Jenkinsfile
stage('Trigger GitOps') {
    steps {
        build job: 'GitOps-Pipeline', 
        parameters: [
            string(name: 'FRONTEND_DOCKER_TAG', value: "${BUILD_NUMBER}"),
            string(name: 'BACKEND_DOCKER_TAG', value: "${BUILD_NUMBER}")
        ]
    }
}
```

## 🔍 Monitoring & Troubleshooting

### Check Pipeline Status
```bash
# View Jenkins build logs
# Check ArgoCD application status
# Verify Kubernetes deployments
kubectl get deployments -n wanderlust
```

### Common Issues
1. **Git Push Failures**: Check GitHub credentials
2. **Manifest Update Errors**: Verify sed syntax and file paths
3. **ArgoCD Sync Issues**: Check repository permissions and paths

## 🛡️ Security Best Practices

- Use Jenkins credentials for Git authentication
- Limit pipeline permissions to necessary resources
- Regularly rotate GitHub tokens
- Monitor pipeline execution logs

## 📈 Benefits of This GitOps Approach

- **Automated Deployments**: No manual intervention required
- **Version Control**: All changes tracked in Git
- **Rollback Capability**: Easy to revert to previous versions
- **Audit Trail**: Complete deployment history
- **Consistency**: Same process for all environments

## 🔄 Integration with CI/CD

This GitOps pipeline integrates seamlessly with the CI pipeline:

```
Developer Push → CI Pipeline → Docker Build → GitOps Pipeline → ArgoCD → Deployment
```

The complete DevSecOps flow ensures secure, automated, and reliable deployments.