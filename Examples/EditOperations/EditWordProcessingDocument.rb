# Import modules
require 'groupdocs_editor_cloud'
require './Common.rb'

#  This example demonstrates how to edit word processing document
class EditWordProcessingDocument
    
    def self.Run()    
        # Create necessary API instances    
        fileApi = GroupDocsEditorCloud::FileApi.from_config($config)
        editApi = GroupDocsEditorCloud::EditApi.from_config($config)
        
        # The document already uploaded into the storage.
        # Load it into editable state
        fileInfo = GroupDocsEditorCloud::FileInfo.new
        fileInfo.file_path = 'WordProcessing/password-protected.docx'
        fileInfo.password = 'password'

        loadOptions = GroupDocsEditorCloud::WordProcessingLoadOptions.new
        loadOptions.file_info = fileInfo
        loadOptions.output_path = "output"

        loadRequest = GroupDocsEditorCloud::LoadRequest.new(loadOptions)        
        loadResult = editApi.load(loadRequest)

        # Download html document
        htmlFile = fileApi.download_file(GroupDocsEditorCloud::DownloadFileRequest.new loadResult.html_path)
        htmlFile.open
        html = htmlFile.read
        htmlFile.close

        # Edit something...
        html = html.gsub("Sample test text", "Hello world")

        # Upload html back to storage
        htmlFile = File.open(htmlFile.path, "w")        
        htmlFile.write(html)
        htmlFile.close
        uploadRequest = GroupDocsEditorCloud::UploadFileRequest.new loadResult.html_path, File.open(htmlFile.path, "r")
        fileApi.upload_file(uploadRequest)

        # Save html back to docx
        saveOptions = GroupDocsEditorCloud::WordProcessingSaveOptions.new
        saveOptions.file_info = fileInfo
        saveOptions.output_path = "output/edited.docx"
        saveOptions.html_path = loadResult.html_path
        saveOptions.resources_path = loadResult.resources_path

        saveRequest = GroupDocsEditorCloud::SaveRequest.new(saveOptions)
        saveResult = editApi.save(saveRequest)        
        
        puts("Document edited: " + saveResult.path)
    end

end