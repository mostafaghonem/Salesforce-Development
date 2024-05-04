@RestResource(urlMapping='/v1/CreateRecord/*')
global class WebServiceToCreateRecordWithFiles {
    
    @HttpPost
    global static void doPost() {
        
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        
        if (request.requestBody == null) {
            returnRequest(response, 400, 'Missing request body');
            return;
        }
        
        tenantDTO requestDTO = (tenantDTO) JSON.deserialize(request.requestBody.toString(), tenantDTO.class);
        Map<String, Object> requestBodyMap = (Map<String, Object>)JSON.deserializeUntyped(request.requestBody.toString());
        List<FileDTO> fileDTOs = (List<FileDTO>)JSON.deserialize(JSON.serialize(requestBodyMap.get('files')), List<FileDTO>.class);

        
        if(requestDTO.action_type == 'Add') {
            String bookingId;
            for(Selected_Units__c booking : [SELECT Id FROM Selected_Units__c 
                                            WHERE Unit__c =: requestDTO.unit_id AND Unit_Stage__c = 'Contracted'])
            {
                bookingId = booking.Id;
            }
            
            Tenant__c newTenant = new Tenant__c();
            newTenant.Email__c = requestDTO.email;
            newTenant.Name = requestDTO.first_name + ' ' + requestDTO.last_name;
            
            insert newTenant;

            List<Attachment> attachmentsToInsert = new List<Attachment>();
            for(FileDTO file : fileDTOs) {
                Attachment attachment = new Attachment(
                    ParentId = newTenant.id,
                    Name = file.fileName,
                    Body = EncodingUtil.base64Decode(file.fileBody)
                );
                attachmentsToInsert.add(attachment);
            }
            insert attachmentsToInsert;
            
            returnRequest(response, 200, newTenant.Name + ' added successfully, with Id ' + newTenant.Id );
            return;
        }
        
        
    }
    public class FileDTO {
        Public String fileName {get; set;}
        Public String fileBody {get;set;}
    }

    public class tenantDTO {
        Public String first_name {get; set;}
        Public String last_name {get; set;}
        Public String email {get; set;}
    }
    
    global static void returnRequest(RestResponse response, Integer statusCode, String message) {
        ResponseDTO dto = new ResponseDTO(message);
        response.statusCode = statusCode;
        response.headers.put('Content-Type', 'application/json');
        //response.responseBody = Blob.valueOf(JSON.serialize(dto));
        response.responseBody = Blob.valueOf('{ "message" : "' + message + '\"'+ '}');
    }
    
    class ResponseDTO {
        public String message {get; set;}
        
        public ResponseDTO(String msg) {
            message = msg;
        }
    }
    
}
