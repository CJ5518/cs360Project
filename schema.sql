CREATE TABLE Users (
    UserID INTEGER PRIMARY KEY,
    Password varchar(255),
    LastName varchar(255),
    FirstName varchar(255),
    Email varchar(255),
    PhoneNumber varchar(255),
    AnnualIncome int
);
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
CREATE TABLE Vendors (
    VendorID INTEGER PRIMARY KEY,
    Password varchar(255),
    CompanyName varchar(255),
    Email varchar(255),
    PhoneNumber varchar(255),
    Description varchar(2048),
    LogoFilePath varchar(255)
);