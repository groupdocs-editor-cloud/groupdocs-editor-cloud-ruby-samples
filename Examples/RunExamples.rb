require './Common.rb'

# Get your app_sid and app_key at https://dashboard.groupdocs.cloud (free registration is required).
$app_sid = "XXXX-XXXX-XXXX-XXXX"
$app_key = "XXXXXXXXXXXXXXXX"

class RunExamples

  puts("Executing Upload Test Files...")
  Common.UploadSampleFiles()

  require './GetSupportedFileTypes.rb'
  puts("Executing GetSupportedFileTypes...")
  GetSupportedFileTypes.Run()

  require './GetDocumentInformation.rb'
  puts("Executing GetDocumentInformation...")
  GetDocumentInformation.Run()  

  require './EditOperations/EditWordProcessingDocument.rb'
  puts("Executing EditWordProcessingDocument...")
  EditWordProcessingDocument.Run()    

  require './EditOperations/EditSpreadsheetDocument.rb'
  puts("Executing EditSpreadsheetDocument...")
  EditSpreadsheetDocument.Run()    

  require './EditOperations/EditPresentationDocument.rb'
  puts("Executing EditPresentationDocument...")
  EditPresentationDocument.Run()     

  require './EditOperations/EditDsvDocument.rb'
  puts("Executing EditDsvDocument...")
  EditDsvDocument.Run()     

  require './EditOperations/EditTextDocument.rb'
  puts("Executing EditTextDocument...")
  EditTextDocument.Run()     

end