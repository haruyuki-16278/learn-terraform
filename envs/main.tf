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
  tr_api-execution-arn = module.api_gateway.tr_api-execution-arn
}

module "api_gateway" {
  prefix = "sample1"
  source = "../modules/api-gateway"
  tr_lambda-invoke_arn = module.lambda.tr_lambda-invole-arn
}
