CREATE TABLE Users (
    UserID INTEGER PRIMARY KEY,
    LastName varchar(255),
    FirstName varchar(255),
    Email varchar(255), Password varchar(255),
    PhoneNumber varchar(255)
, AnnualIncome int);
CREATE TABLE Homes (
    HomeID INTEGER PRIMARY KEY,
    HomeOwner INTEGER,
    Address varchar(255),
    City varchar(255),
    State varchar(255),
    ZipCode int,
    Bedrooms int,
    Bathrooms int,
    HalfBaths int,
    SquareFootage int,
    CarpetSquareFootage int,
    ConstructionYear int,
    FOREIGN KEY(HomeOwner) REFERENCES Users(UserID)
);
