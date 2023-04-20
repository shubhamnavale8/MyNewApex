@RESTResource(urlMapping='\CreateContact\')
global class RestApiForContact {
    @HTTPPost
    public static String methodForContactRestApi(){
       RestRequest req=RestContext.request;
       RestResponse res=RestContext.response;

    }
}