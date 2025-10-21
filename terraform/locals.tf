locals {
  common_tags = {
    Environment = var.environment
    Project     = "wanderlust-mega-project"
    ManagedBy   = "terraform"
    CreatedBy   = "Sujal_Malhotra"
    CreatedDate = formatdate("YYYY-MM-DD", timestamp())
  }

}