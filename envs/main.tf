module "dynamodb" {
  prefix = "sample1"
  source = "../modules/dynamodb"
}

module "iam" {
  prefix = "sample1"
  source = "../modules/iam"
  employee_list_table-arn = module.dynamodb.employee_list_table.arn
}
