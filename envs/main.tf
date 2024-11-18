module "dynamodb" {
  prefix = "sample1"
  source = "../modules/dynamodb"
}

module "iam" {
  prefix = "sample1"
  source = "../modules/iam"
  employee_list_table-arn = module.dynamodb.employee_list_table.arn
}

module "lambda" {
  prefix = "sample1"
  source = "../modules/lambda"
  employee_list_table-name = module.dynamodb.employee_list_table.name
  tr_lambda_role-arn = module.iam.tr_lambda_role-arn
}
