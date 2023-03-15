public class WhatsAppController {
    @AuraEnabled
    public static Boolean sendTemplateMessage(string contactId){
        Contact contactDetail = [Select id, Phone from contact Where Id=:contactId ];
        String whatsAppNumber = '91' + contactDetail.Phone;
        system.debug('whatsappnumber:'+whatsAppNumber);
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://graph.facebook.com/v15.0/115015398145347/messages');
        req.setHeader('Content-Type','application/json');
        req.setMethod('POST');
        
        String body = '{"messaging_product":"whatsapp", "to":"'+whatsAppNumber+'","type":"template","template":{"name":"hello_world","language":{"code":"en_US"}}}';
        req.setBody(body);
        String apiToken = 'EAANpKR4KiToBAEagMwq20LvURFbTNV2iKRlZAsZCha8IAC27SeqbrXGiSnLMeZAOWgSH0AM0KcElahBk44ZCKqqu5YfplEaocsEcKggkROl8fQLZBcI3cZCKjtKE4NI3bYeLnouTZCiVT6lg41PZCp5XGof9UXAquWZApHUnZB0ZAwQZBHZBHePZChe9O2VzD7zejt1o5DMdTb0fTuZAAZDZD';
        req.setHeader('Authorization', 'Bearer' +apiToken);
        HttpResponse res =http.send(req);
        system.debug('response:'+req.getBody());
        system.debug(res.getStatusCode());
        if(res.getStatusCode()==200){
         return true;
            
        }
        return false;
    }

}