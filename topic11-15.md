🧱 Terraform Notes — Part 3 (Topics 11–15)
1️⃣1️⃣ Multiple Variables in Terraform

In real-world Terraform projects, you’ll often need many variables — region, instance type, bucket name, etc.

You can define all variables in a single file, commonly named variables.tf.

Example

variables.tf

variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Name of S3 bucket"
  default     = "ashu-demo-bucket"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}


main.tf

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucket_name
}

resource "aws_instance" "myec2" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
}


✅ Terraform automatically detects and uses variables from variables.tf.

1️⃣2️⃣ Variable Types

Terraform variables can have data types that define what kind of value they accept.

Common Types
Type	Description	Example
string	Text values	"ap-south-1"
number	Numeric values	2, 100
bool	Boolean values	true, false
list	Ordered collection	["t2.micro", "t2.small"]
map	Key-value pairs	{ name = "ashu", dept = "cloud" }
object	Complex data structure	{ name = string, id = number }
tuple	Fixed-length list of mixed types	["ap-south-1", 1, true]
Example
variable "instance_count" {
  type        = number
  default     = 2
}

variable "enable_monitoring" {
  type        = bool
  default     = true
}


✅ Terraform will throw an error if the wrong type is provided.

1️⃣3️⃣ List Variable

A list variable is an ordered sequence of values, accessed by index (starting from 0).

Example

variables.tf

variable "instance_types" {
  type    = list(string)
  default = ["t2.micro", "t2.small", "t3.micro"]
}


main.tf

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_types[0]   # Access first value
}


✅ Output Example

terraform apply


→ EC2 instance created with t2.micro.

Dynamic Example

Looping over list values:

resource "aws_instance" "multi" {
  count         = length(var.instance_types)
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_types[count.index]
}


✅ Creates 3 EC2 instances using list elements dynamically.

1️⃣4️⃣ Functions in Terraform

Terraform has many built-in functions for working with strings, numbers, collections, and more.

Function Syntax
<FUNCTION_NAME>(arguments)

Common Terraform Functions
Function	Description	Example
length(list)	Count number of elements	length(var.instance_types) → 3
upper(string)	Convert to uppercase	upper("aws") → "AWS"
lower(string)	Convert to lowercase	lower("Terraform") → "terraform"
format()	Format strings	format("Name-%s", var.bucket_name)
concat()	Combine lists	concat(["a"], ["b"]) → ["a", "b"]
join()	Join list into string	join("-", ["dev", "ashu", "tf"]) → "dev-ashu-tf"
lookup()	Get map value by key	lookup(var.instance_map, "dev")
element()	Access list element	element(var.instance_types, 1) → "t2.small"
Example
output "bucket_upper" {
  value = upper(var.bucket_name)
}


✅ Output: "ASHU-DEMO-BUCKET"

1️⃣5️⃣ Map Variable

Map variables are key-value pairs — very useful for tagging, environment setup, or dynamic values.

Example

variables.tf

variable "instance_ami" {
  type = map(string)
  default = {
    dev  = "ami-0c55b159cbfafe1f0"
    prod = "ami-0d12345abcd6789ef"
  }
}


main.tf

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = var.instance_ami["dev"]
  instance_type = "t2.micro"
}


✅ Terraform picks the AMI based on the environment key.

Dynamic Map Access Example
variable "env" {
  default = "prod"
}

resource "aws_instance" "dynamic" {
  ami           = var.instance_ami[var.env]
  instance_type = "t2.micro"
}


✅ Changing only the variable env automatically switches AMI (Dev/Prod).

⚙️ Summary Table (Topics 11–15)
Topic	Key Learning
11. Multiple Variables	Store all reusable values in variables.tf
12. Variable Types	string, number, bool, list, map, object, tuple
13. List Variable	Ordered data; can loop using count
14. Functions	Built-in functions to manipulate data
15. Map Variable	Key-value pairs; used for environment-specific values