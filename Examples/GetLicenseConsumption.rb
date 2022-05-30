# Import modules
require './Common.rb'

#  This example demonstrates how to get metered license consumption info
class GetLicenseConsumption
    
    def self.Run()        
        licenseApi = GroupDocsEditorCloud::LicenseApi.from_config($config)
        response = licenseApi.get_consumption_credit()
        puts("Credits = " + response.credit)
    end

end