A:File Structure Of FilterSDK Specification:

Root(Assets/Internal Storage)
	
	filter
	
		filters  //Filters Folder
			 pictureFilter
			 	localFilter
			 		filters
			 			item1
						item2
						...
			 		filter.properties
			 	marketFilter
			 		filters
			 			item1
						item2
						...
			 		filter.properties
			 videoFilter
			 	localFilter
			 		filters
			 			item1
						item2
						...
			 		filter.properties
			 	marketFilter
			 		filters
			 			item1
						item2
						...
			 		filter.properties
			 public //public resources
			 	item1
				item2
				...

		waterMark	//WaterMarks Folder
			localWaterMark
				waterMarks
					item1
					item2
					...
				filter.properties
			marketWaterMark
				waterMarks
					item1
					item2
					...
				filter.properties
			public //public resources
				item1
				item2
				...



B:About Properties

	Properties file keeps track of current filters(filter or waterMark),witch is a JSONArray. Every single property consists of two part ,FolderName and FilterId ,just like {"name","filter1","id","filter1's Id"}.
	 
