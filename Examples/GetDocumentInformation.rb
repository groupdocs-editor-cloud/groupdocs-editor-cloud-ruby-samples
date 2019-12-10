# Import modules
require 'groupdocs_editor_cloud'
require './Common.rb'

#  This example demonstrates how to get document info
class GetDocumentInformation
    
    def self.Run()        
        infoApi = GroupDocsEditorCloud::InfoApi.from_keys($app_sid, $app_key)
        fileInfo = GroupDocsEditorCloud::FileInfo.new
        fileInfo.file_path = 'WordProcessing/password-protected.docx'
        fileInfo.password = 'password'
        request = GroupDocsEditorCloud::GetInfoRequest.new(fileInfo)
        response = infoApi.get_info(request)
        puts("Pages count = " + response.page_count.to_s)
    end

end