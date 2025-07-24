#!/bin/bash  
mlr --icsv --opprint \
filter '$id !=""  && is_numeric($id) &&  substr($imdb_id,0,1) == "tt"  && $imdb_id !="" &&  
  is_numeric($popularity) && $popularity != ""  &&  is_numeric($budget) && $budget != "" &&  is_numeric($revenue) && 
  $revenue >0 && is_string($original_title)  && $original_title !="" &&
  ($original_title  !=~ "^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}$") && is_string($cast)  && 
  $cast !=""  && ($homepage == "" || $homepage =~ "^https?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$") &&
  (is_string($director)  && $director !="" && $original_title  !=~ "^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}$") &&  is_string($tagline) &&  is_string($keywords)  &&
  is_string($overview)  &&   is_numeric($runtime)  && $runtime !="" &&   is_string($keywords)  &&
  is_string($genres) && $genres !="" && is_string($production_companies)  && $production_companies !="" && 
  is_numeric($vote_count)  && is_numeric($vote_average)  &&  $vote_average !="" &&  $vote_average != null &&
  is_numeric($budget_adj)  && $budget_adj !="" && $budget_adj >=0 && is_numeric($revenue_adj)  && $revenue_adj !=""   && 
  $revenue_adj >=0 &&  $release_year =~ "^[0-9]{4}$" &&
  ($release_date =~ "^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$"  || $release_date =~ "^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}$" || $release_date =~ "^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}$"  || $release_date =~ "^[0-9]{1,2}-[0-9]{1,2}-[0-9]{2}$")' \
   then nest --explode --values --across-records -f genres  --nested-fs '|' \
   then count -g genres   \
   then sort -n genres \
   tmdb-movies.csv 
