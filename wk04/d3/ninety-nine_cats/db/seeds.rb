ActiveRecord::Base.transaction do

  Cat.create(
    name: "Darryl",
    age: 2,
    birth_date: '8/1/2012',
    color: 'brown',
    sex: "M")

  Cat.create(
    name: "Tyler",
    age: 2,
    birth_date: '8/1/2012',
    color: 'grey',
    sex: "M")

  Cat.create(
    name: "Dan",
    age: 15,
    birth_date: '8/1/2000',
    color: 'white',
    sex: "M")

  Cat.create(
    name: "Bob",
    age: 4,
    birth_date: '9/1/2010',
    color: 'grey',
    sex: "M")
    
    
  CatRentalRequest.create(
    cat_id: 1, 
    start_date: '01/01/2001', 
    end_date: '01/05/2004'
  )
  
  CatRentalRequest.create(
    cat_id: 1, 
    start_date: '01/01/2006', 
    end_date: '01/05/2007'
  )
  
  CatRentalRequest.create(
    cat_id: 1, 
    start_date: '01/01/2007', 
    end_date: '01/05/2008'
  )
  
  CatRentalRequest.create(
    cat_id: 1, 
    start_date: '01/01/2009', 
    end_date: '01/05/2010'
  )
  
  CatRentalRequest.create(
    cat_id: 2, 
    start_date: '01/01/2001', 
    end_date: '01/05/2004', 
    status: 'APPROVED'
  )
    
end