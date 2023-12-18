resource "aws_s3_bucket" "static_files" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "static_files" {
  bucket = aws_s3_bucket.static_files.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "static_files" {
  bucket = aws_s3_bucket.static_files.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.static_files.arn,
          "${aws_s3_bucket.static_files.arn}/*",
        ]
      },
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "static_files" {
  bucket = aws_s3_bucket.static_files.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "files" {
  depends_on   = [aws_s3_bucket.static_files]
  for_each     = fileset("${path.root}", "files/*.html")
  bucket       = var.bucket_name
  key          = basename(each.value)
  source       = each.value
  content_type = "text/html"
  acl          = "public-read"
}

//resource "aws_route53_record" "website" {
//  depends_on = [aws_s3_bucket.static_files, aws_s3_bucket_website_configuration.static_files]
//  zone_id = aws_s3_bucket.static_files.hosted_zone_id
//  name = "website.io"
//  type = "A"
//  ttl = "300"
//  records = [aws_s3_bucket_website_configuration.static_files.website_domain]
//}
