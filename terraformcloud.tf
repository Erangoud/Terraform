terraform { 
  backend "remote" { 
    
    organization = "Fundoo_3Tire" 

    workspaces { 
      name = "CLI" 
    } 
  } 
}