# Import modules
require 'groupdocs_editor_cloud'
require './Common.rb'

# This example demonstrates how to edit presentation document
class EditPresentationDocument
    
    def self.Run()    
        # Create necessary API instances    
        fileApi = GroupDocsEditorCloud::FileApi.from_keys($app_sid, $app_key)
        editApi = GroupDocsEditorCloud::EditApi.from_keys($app_sid, $app_key)
        
        # The document already uploaded into the storage.
        # Load it into editable state
        fileInfo = GroupDocsEditorCloud::FileInfo.new
        fileInfo.file_path = 'Presentation/with-notes.pptx'        

        loadOptions = GroupDocsEditorCloud::PresentationLoadOptions.new
        loadOptions.file_info = fileInfo
        loadOptions.output_path = "output"
        loadOptions.slide_number = 0

        loadRequest = GroupDocsEditorCloud::LoadRequest.new(loadOptions)        
        loadResult = editApi.load(loadRequest)

        # Download html document
        htmlFile = fileApi.download_file(GroupDocsEditorCloud::DownloadFileRequest.new loadResult.html_path)
        htmlFile.open
        html = htmlFile.read
        htmlFile.close

        # Edit something...
        html = html.gsub("Slide sub-heading", "Hello world!")

        # Upload html back to storage
        htmlFile = File.open(htmlFile.path, "w")        
        htmlFile.write(html)
        htmlFile.close
        uploadRequest = GroupDocsEditorCloud::UploadFileRequest.new loadResult.html_path, File.open(htmlFile.path, "r")
        fileApi.upload_file(uploadRequest)

        # Save html back to pptx
        saveOptions = GroupDocsEditorCloud::PresentationSaveOptions.new
        saveOptions.file_info = fileInfo
        saveOptions.output_path = "output/edited.pptx"
        saveOptions.html_path = loadResult.html_path
        saveOptions.resources_path = loadResult.resources_path

        saveRequest = GroupDocsEditorCloud::SaveRequest.new(saveOptions)
        saveResult = editApi.save(saveRequest)        
        
        puts("Document edited: " + saveResult.path)
    end

end