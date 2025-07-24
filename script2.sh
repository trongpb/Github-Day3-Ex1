#!/bin/bash 
 mlr --icsv --opprint put '  
 $vote_average =  float($vote_average) ;
$Month =   int(index($release_date, "/") == 2 ? substr($release_date, 0, 0) : substr($release_date, 0, 1));
$Day = int(index($release_date, "/") == 2  
?
(index(substr($release_date,2,strlen($release_date)-1), "/") == 2 ? substr(substr($release_date,2,strlen($release_date)-2), 0, 0) : substr(substr($release_date,2,strlen($release_date)-2), 0, 1))
: 
(index(substr($release_date,3,strlen($release_date)-2), "/") == 2 ? substr(substr($release_date,3,strlen($release_date)-2), 0, 0) : substr(substr($release_date,3,strlen($release_date)-2), 0, 1)));
' then  put '$release_year = int($release_year)'   \
  then  filter '$id !=""  && is_numeric($id) && is_numeric($Month) && substr($imdb_id,0,1) == "tt"  && $imdb_id !="" &&  
  is_numeric($popularity) && $popularity != ""  &&  is_numeric($budget) && $budget != "" &&  is_numeric($revenue) && 
  $revenue != "" && is_string($original_title)  && $original_title !="" &&
  ($original_title  !=~ "^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4}$") && is_string($cast)  && 
  $cast !=""  && ($homepage == "" || $homepage =~ "^https?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$") &&
  is_string($director)  && $director !="" &&  is_string($tagline) &&  is_string($keywords)  &&
  is_string($overview)  &&   is_numeric($runtime)  && $runtime !="" &&   is_string($keywords)  &&
  is_string($genres)  && is_string($production_companies)  && $production_companies !="" && 
  is_numeric($vote_count)  && is_numeric($vote_average)  &&  $vote_average !="" &&  $vote_average != null &&
  is_numeric($budget_adj)  && $budget_adj !="" && $budget_adj >=0 && is_numeric($revenue_adj)  && $revenue_adj !=""   && 
  $revenue_adj >=0 &&  $release_year =~ "^[0-9]{4}$" &&
  ($release_date =~ "^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$"  || $release_date =~ "^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}$" || $release_date =~ "^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}$"  || $release_date =~ "^[0-9]{1,2}-[0-9]{1,2}-[0-9]{2}$") &&
  $vote_average >  7.5' \
  then uniq -f id,imdb_id,popularity,budget,revenue,original_title,cast,homepage,director,tagline,keywords,overview,runtime,genres,production_companies,release_date,vote_count,vote_average,release_year,budget_adj,revenue_adj,Month,Day \
  tmdb-movies.csv > project1-5.csv