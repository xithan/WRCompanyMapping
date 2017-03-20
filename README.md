# WRCompanyMapping
Given a Corpus of WikiRate Company Names and a new (incoming) Company Name, CompanyMapper class, finds the closest match if exists based on the calculated tf-idf similarity and a defined threshold.

          mapper = CompanyMapper.new(companiesCorpus)
          puts mapper.map(new_company, 0.5)
          
In main_script.rb a working example can be found.
