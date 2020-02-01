DROP DATABASE LANCHAT

DROP TABLE ROUNDS
DROP TABLE GAMES
DROP TABLE DECKS
DROP TABLE USER_CARDS
DROP TABLE SUGGEST
DROP TABLE CARDS
DROP TABLE CONTAIN
DROP TABLE PRODUCTS
DROP TABLE CATEGORIES
DROP TABLE SHOPPINGCARTS
DROP TABLE EXCHANGE
DROP TABLE USERS
DROP TABLE MESSAGESENT
DROP TABLE ROOMS
GO

CREATE DATABASE LANCHAT
GO
use LANCHAT 
GO

CREATE TABLE ROOMS(
Id_Room INT PRIMARY KEY NOT NULL IDENTITY(1,1),
Label_Room VARCHAR(50) NOT NULL
);

CREATE TABLE MESSAGESENT(
Id_Message INT PRIMARY KEY NOT NULL,
Date_Message DATETIME DEFAULT GETDATE() NOT NULL,
Mess_Header_Message VARCHAR(20) NOT NULL CHECK (Mess_Header_Message IN ('AUTH','QUIT','USERS','ROM_LIST','ROOM_POST_ROOM_JOIN','ROOM_QUIT','MOD')),
From_Message VARCHAR(50) NOT NULL,
To_Message VARCHAR(50) NOT NULL,
Token_Message VARCHAR(50) NOT NULL CHECK(Token_Message >8 AND Token_Message<50),
Mess_MESSAGES VARCHAR(250)
);

CREATE TABLE USERS(
Id_User INT NOT NULL PRIMARY KEY IDENTITY(1,1),
Mail_User VARCHAR(50) UNIQUE NOT NULL,
UserRight_User INT NOT NULL,
Avatar_User VARBINARY(MAX) NOT NULL,
Cred_User INT,
Victory_User INT,
Loss_User INT,
Pseudo_User VARCHAR(50) UNIQUE NOT NULL,
Password_User VARCHAR(15) NOT NULL,
Exp_Pool_User INT
);

CREATE TABLE EXCHANGE(
Id_Room INT NOT NULL,
Id_MESSAGE INT NOT NULL,
Id_User INT NOT NULL,
CONSTRAINT FK_id_Room FOREIGN KEY (Id_Room) REFERENCES ROOMS(Id_Room),
CONSTRAINT FK_Id_Message FOREIGN KEY(Id_Message) REFERENCES MESSAGESENT(Id_Message),
CONSTRAINT FK_Id_User FOREIGN KEY(Id_User) REFERENCES USERS (Id_User),
CONSTRAINT PK_EXCHANGE PRIMARY KEY(Id_Room,Id_Message,Id_User)
);

CREATE TABLE SHOPPINGCARTS(
Id_Shopping INT NOT NULL PRIMARY KEY IDENTITY(1,1),
Date_Shopping DATE NOT NULL,
Id_User INT NOT NULL,
CONSTRAINT FK_SHOP_Id_User FOREIGN KEY(Id_User)REFERENCES USERS(Id_User)
);

CREATE TABLE CATEGORIES(
Id_Category INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Type_Category VARCHAR(10) NOT NULL CHECK(Type_Category IN('CARTE', 'BONUSEXP','BONUSSTAT'))
);

CREATE TABLE PRODUCTS(
Id_Product INT PRIMARY KEY NOT NULL IDENTITY(1,1),
Name_Product VARCHAR(50) NOT NULL UNIQUE,
Label_Product VARCHAR(150),
Price_Product INT NOT NULL,
Quantity_Product INT,
Id_Category INT NOT NULL,
CONSTRAINT FK_Id_Category FOREIGN KEY(Id_Category)REFERENCES CATEGORIES(Id_Category)
);

CREATE TABLE CONTAIN(
Id_Product INT NOT NULL,
Id_Shopping INT NOT NULL,
Quantity INT NOT NULL,
Price INT NOT NULL,
CONSTRAINT FK_Id_Product FOREIGN KEY(Id_Product)REFERENCES PRODUCTS(Id_Product),
CONSTRAINT FK_Id_Shopping FOREIGN KEY(Id_Shopping)REFERENCES SHOPPINGCARTS(Id_Shopping),
CONSTRAINT PK_CONTAIN PRIMARY KEY(Id_Product,Id_Shopping)
);
CREATE TABLE CARDS(
Id_Card INT NOT NULL PRIMARY KEY IDENTITY(1,1),
Name_Card VARCHAR(50) NOT NULL UNIQUE,
Description_Card VARCHAR(150) NOT NULL,
Atk_b_Card INT NOT NULL CHECK(Atk_b_Card > 0),
Def_b_Card INT NOT NULL CHECK(Def_b_Card > 0),
Pow_b_Card INT NOT NULL CHECK(Pow_b_Card BETWEEN 1 AND 9),
Evol_Card INT NOT NULL CHECK (Evol_Card IN('ATK', 'DEF', 'MIXTE')),
Img_Card VARBINARY(MAX) NOT NULL,
CONSTRAINT cst_Atk_Def_Pow_Sum_CARDS CHECK ((Atk_b_card+Def_b_Card + Pow_b_Card=24))
);

CREATE TABLE SUGGEST(
Id_Card INT NOT NULL,
Id_Product INT NOT NULL,
CONSTRAINT FK_Id_Card_SUGGEST FOREIGN KEY (Id_Card)REFERENCES CARDS(Id_Card),
CONSTRAINT FK_Id_Product_SUGGEST FOREIGN KEY(Id_Product)REFERENCES PRODUCTS(Id_Product),
CONSTRAINT PK_SUGGEST PRIMARY KEY(Id_Card, Id_Product)
);

CREATE TABLE USER_CARDS(
Lvl_User_Card INT NOT NULL CHECK(Lvl_User_Card BETWEEN 1 AND 30),
Atk_User_Card INT NOT NULL CHECK(Atk_User_Card > 0),
Def_User_Card INT NOT NULL CHECK(Def_User_Card > 0),
Pow_User_Card INT NOT NULL CHECK(Pow_User_Card BETWEEN 1 AND 9),
Exp_User_Card INT NOT NULL,
Id_User INT NOT NULL,
Id_Card INT NOT NULL,
CONSTRAINT FK_Id_User_Card FOREIGN KEY (Id_User)REFERENCES USERS(Id_User),
CONSTRAINT FK_Id_Card_USER_CARDS FOREIGN KEY(Id_Card)REFERENCES CARDS,
CONSTRAINT PK_USER_CARDS PRIMARY KEY(Id_User, Id_Card),
--CONSTRAINT cst_Atk_Def_Pow_Sum_USER_CARDS CHECK (Atk_User_Card + Def_User_Card + Pow_User_Card=24)
);

CREATE TABLE DECKS(
Id_Deck INT PRIMARY KEY NOT NULL IDENTITY(1,1),
Name_Deck VARCHAR(25) NOT NULL DEFAULT 'Deck',
Rank_Deck INT NOT NULL,
Id_User INT NOT NULL,
Id_Card1 INT NOT NULL,
Id_Card2 INT NOT NULL,
Id_Card3 INT NOT NULL,
Id_Card4 INT NOT NULL,
CONSTRAINT FK_USER_CARDS_DECKS_1 FOREIGN KEY(Id_User, Id_Card1)REFERENCES USER_CARDS(Id_User, Id_Card),
CONSTRAINT FK_USER_CARDS_DECKS_2 FOREIGN KEY(Id_User, Id_Card2)REFERENCES USER_CARDS(Id_User, Id_Card),
CONSTRAINT FK_USER_CARDS_DECKS_3 FOREIGN KEY(Id_User, Id_Card3)REFERENCES USER_CARDS(Id_User, Id_Card),
CONSTRAINT FK_USER_CARDS_DECKS_4 FOREIGN KEY(Id_User, Id_Card4)REFERENCES USER_CARDS(Id_User, Id_Card),
);

CREATE TABLE GAMES(
Id_Game INT PRIMARY KEY NOT NULL IDENTITY(1,1),
Date_Crea_Game DATETIME NOT NULL,
IP_J1_Game CHAR(15) NOT NULL,
IP_J2_Game CHAR(15) NOT NULL
);

CREATE TABLE ROUNDS(
Id_Round INT NOT NULL,
Id_Game INT NOT NULL,
Card_J1_Round INT NOT NULL,
Card_J2_Round INT NOT NULL,
Card_Win_Round INT NOT NULL,
Id_User1 INT NOT NULL,
Id_User2 INT NOT NULL,
Id_Card1 INT NOT NULL,
Id_Card2 INT NOT NULL,
CONSTRAINT FK_USER_CARDS_1 FOREIGN KEY(Id_User1, Id_Card1)REFERENCES USER_CARDS(Id_User, Id_Card),
CONSTRAINT FK_USER_CARDS_2 FOREIGN KEY(Id_User2, Id_Card2)REFERENCES USER_CARDS(Id_User, Id_Card),
CONSTRAINT FK_Id_Game FOREIGN KEY(Id_Game)REFERENCES GAMES(Id_Game),
CONSTRAINT PK_ROUNDS PRIMARY KEY(Id_Round, Id_Game)
);
