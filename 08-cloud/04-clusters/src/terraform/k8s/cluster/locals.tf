locals {
  node_labels = length(keys(var.node_labels)) > 0 ? var.node_labels : {
  }

  labels = length(keys(var.labels)) > 0 ? var.labels : {
  }
}