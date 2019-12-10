# Load the gem
require 'groupdocs_editor_cloud'

$app_sid = ""
$app_key = ""

class Common
  
  def self.UploadSampleFiles()

    @TestFiles=  Dir.glob("Resources/**/*.*")

    # Api initialization
    storageApi = GroupDocsEditorCloud::StorageApi.from_keys($app_sid, $app_key)
    fileApi = GroupDocsEditorCloud::FileApi.from_keys($app_sid, $app_key)

    puts("Files Count: "+((@TestFiles).length).to_s)
    @TestFiles.each do |item|
      dstPath = item.gsub('Resources/', '')
      puts("File to Upload: " + dstPath)
      fileExistRequest = GroupDocsEditorCloud::ObjectExistsRequest.new(dstPath)
      fileExistsResponse = storageApi.object_exists(fileExistRequest)
      if fileExistsResponse.exists == false
        file = File.open(item, "r")
        uploadRequest = GroupDocsEditorCloud::UploadFileRequest.new(dstPath, file)
        fileApi.upload_file(uploadRequest)
        puts("Uploaded missing file: " + item)
      end
    end

    puts("File Uploading completed..")
  end
end