def nested_dirallfile(root="."): 
    allfiles_path = []  
    for path, dirs, files in os.walk(root): 
    #allfiles_path = []  
        for file in files: 
        #print(os.path.join(path, file)) 
            allfiles_path.append(os.path.join(path, file))       
    return  allfiles_path 