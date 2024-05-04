# Apex REST Web Service supports multiple files
this is an apex REST web service that supports creating a new custom object's record with multiple files as record's attachments, 
by encoding the images to base64 encoding and putting them in the request body in the files object

## the request body structure
```json
{
    "first_name":"Mostafa",
    "last_name" : "Ghonem",
    "mobile_number" : "1122334455",
    "email": "mostafaghonem@email.com",
    "files":[{
        "fileName":"file.png",
        "fileBody":"Image base64 encoding"
        },
        {
        "fileName":"file.png",
        "fileBody":"Image base64 encoding"
        }]
}

```
