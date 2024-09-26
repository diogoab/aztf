resource "local_sensitive_file" "this" {
  content         = var.file_content
  filename        = var.file_name
  file_permission = var.file_permission
}
