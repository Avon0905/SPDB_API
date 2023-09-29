library(dplyr)
library(utils)

spdb.info = function() 
{
	data_info = read.table("https://scproteomicsdb.com/static/api/SPDB_data_info.txt", sep = "\t", header = T)
	return(data_info)
}

spdb.list = function(technologies = NA, species = NA, tissues = NA, diseases = NA)
{
	data_info = spdb.info()
	if(!is.na(technologies))
	{
		data_info = data_info[data_info[,"Technology"] %in% technologies,]
	}
	if(!is.na(species))
	{
		data_info = data_info[data_info[,"Species"] %in% species,]
	}
	if(!is.na(tissues))
	{
		data_info = data_info[data_info[,"Tissue"] %in% tissues,]
	}
	if(!is.na(diseases))
	{
		data_info = data_info[data_info[,"Disease"] %in% diseases,]
	}
	data_info = as_tibble(data_info)
	return(data_info)
}

spdb.save = function(datalist = NA, savedir = getwd())
{
	cat("Checking if files are all available...")
	cat("\n")

	data_info = spdb.info()
	all_datalist = as.character(data_info$ID)
	wrong_id = setdiff(datalist, all_datalist)
	if(length(wrong_id) > 0)
	{
		return(message("Error! There exist unmatched ids : ", wrong_id))
	}
	cat("Downloading from spdb websever...")
	cat("\n")
	cat("This will be a long progress! Please waiting...")
	cat("\n")

	for(i in 1:length(datalist))
	{
		filename = paste0(datalist[i], "_preprocessed_cluster_UMAP.rds")
		url = paste0("https://scproteomicsdb.com/static/file/rds_file/", filename)
		try(download.file(url, destfile = file.path(savedir,filename)))
	}
}

spdb.load = function(dataID)
{
	cat("Checking if data is available...")
	cat("\n")

	data_info = spdb.info()
	if(dataID %in% as.character(data_info$ID))
	{
		cat("Start loading data...")
		cat("\n")
		filename = paste0(dataID, "_preprocessed_cluster_UMAP.rds")
		fileurl = paste0("https://scproteomicsdb.com/static/file/rds_file/", filename)
		data = readRDS(url(fileurl))
		return(data)
	}else{
		return(message("Error! ", dataID, " is not available!"))
	}
}

