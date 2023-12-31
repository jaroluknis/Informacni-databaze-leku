CREATE DATABASE [MedicineDatabase];
GO

USE [MedicineDatabase]
GO

exec sp_fulltext_database 'enable';			-- ENABLE FULLTEXT SEARCH (we asume it is already installed, if not check tutorial in thesis work in section Inštalácia a konfigurácia)

CREATE FULLTEXT CATALOG [DocumentFullTextCatalog] WITH ACCENT_SENSITIVITY = ON
GO

CREATE FULLTEXT CATALOG [MedicineFullTextCatalog] WITH ACCENT_SENSITIVITY = ON
GO

CREATE TYPE [dbo].[EmailPhoneTable] AS TABLE(
	[Value] [nvarchar](100) NULL
)
GO

CREATE TYPE [dbo].[HoursTable] AS TABLE(
	[Day] [nvarchar](10) NULL,
	[Time] [nvarchar](25) NULL
)
GO

CREATE TYPE [dbo].[Pills] AS TABLE(
	[SUKL_Code] [nvarchar](7) NULL,
	[MandatoryReport] [nvarchar](1) NULL,
	[Name] [nvarchar](70) NULL,
	[MedicalPower] [nvarchar](24) NULL,
	[Form] [nvarchar](255) NULL,
	[Packing] [nvarchar](22) NULL,
	[WayOfUse] [nvarchar](255) NULL,
	[Supplement] [nvarchar](75) NULL,
	[Cover] [nvarchar](255) NULL,
	[RegistrationHolder] [nvarchar](200) NULL,
	[HolderCountry] [nvarchar](100) NULL,
	[ActualHolder] [nvarchar](200) NULL,
	[ActualHolderCountry] [nvarchar](100) NULL,
	[RegistrationState] [nvarchar](300) NULL,
	[RegistrationValidTo_DDMMYY] [nvarchar](8) NULL,
	[UnlimitedRegistration] [nvarchar](1) NULL,
	[OnMarketTo_DDMMYY] [nvarchar](8) NULL,
	[IndicationGroup] [nvarchar](58) NULL,
	[ATC] [nvarchar](7) NULL,
	[ATC_Name] [nvarchar](300) NULL,
	[RegistrationNumber] [nvarchar](16) NULL,
	[ParallelImport_Number] [nvarchar](11) NULL,
	[ParallelImport_Importer] [nvarchar](4) NULL,
	[ParallelImport_Country] [nvarchar](3) NULL,
	[RegistrationProcedure] [nvarchar](100) NULL,
	[DefinedDailyDose_MedicineAmount] [nvarchar](10) NULL,
	[DefinedDailyDose_Union] [nvarchar](4) NULL,
	[DefinedDailyDose_AmountInPackage] [nvarchar](18) NULL,
	[WHO_Index] [nvarchar](8) NULL,
	[MedicalSubstances] [nvarchar](2000) NULL,
	[Dispensing] [nvarchar](300) NULL,
	[Addiction] [nvarchar](4) NULL,
	[Doping] [nvarchar](300) NULL,
	[NarVla] [nvarchar](2) NULL,
	[SuppliedPast_HalfYear] [nvarchar](2) NULL,
	[Ean] [nvarchar](10) NULL,
	[Braille] [nvarchar](4) NULL,
	[Expiration] [nvarchar](5) NULL,
	[Expoiration_Type] [nvarchar](5) NULL,
	[RegisteredName] [nvarchar](255) NULL,
	[MRP_Number] [nvarchar](15) NULL,
	[LegalRegistrationBase] [nvarchar](8) NULL,
	[ProtectiveElement] [nvarchar](2) NULL
)
GO

CREATE TYPE [dbo].[SPCMapping] AS TABLE(
	[MedicineSUKL] [nvarchar](7) NOT NULL,
	[DocumentName] [nvarchar](max) NOT NULL
)
GO

CREATE TYPE [dbo].[StructuredDocs] AS TABLE(
	[DocumentName] [nvarchar](255) NULL,
	[Indications] [nvarchar](max) NULL,
	[Contraindications] [nvarchar](max) NULL,
	[SideEffects] [nvarchar](max) NULL,
	[Validity] [nvarchar](max) NULL,
	[Warnings] [nvarchar](max) NULL,
	[Interactions] [nvarchar](max) NULL,
	[Dosage] [nvarchar](max) NULL,
	[Compositions] [nvarchar](max) NULL,
	[Substances] [nvarchar](max) NULL,
	[Overdose] [nvarchar](max) NULL
)
GO

CREATE TYPE [dbo].[WebTable] AS TABLE(
	[Value] [nvarchar](255) NULL
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicinePills](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SUKL_Code] [nvarchar](7) NOT NULL,
	[MandatoryReport] [nvarchar](1) NULL,
	[Name] [nvarchar](70) NULL,
	[MedicalPower] [nvarchar](24) NULL,
	[Form] [nvarchar](255) NULL,
	[Packing] [nvarchar](22) NULL,
	[WayOfUse] [nvarchar](255) NULL,
	[Supplement] [nvarchar](75) NULL,
	[Cover] [nvarchar](255) NULL,
	[RegistrationHolder] [nvarchar](200) NULL,
	[HolderCountry] [nvarchar](100) NULL,
	[ActualHolder] [nvarchar](200) NULL,
	[ActualHolderCountry] [nvarchar](100) NULL,
	[RegistrationState] [nvarchar](300) NULL,
	[RegistrationValidTo_DDMMYY] [nvarchar](8) NULL,
	[UnlimitedRegistration] [nvarchar](1) NULL,
	[OnMarketTo_DDMMYY] [nvarchar](8) NULL,
	[IndicationGroup] [nvarchar](58) NULL,
	[ATC] [nvarchar](7) NULL,
	[ATC_Name] [nvarchar](300) NULL,
	[RegistrationNumber] [nvarchar](16) NULL,
	[ParallelImport_Number] [nvarchar](11) NULL,
	[ParallelImport_Importer] [nvarchar](4) NULL,
	[ParallelImport_Country] [nvarchar](3) NULL,
	[RegistrationProcedure] [nvarchar](100) NULL,
	[DefinedDailyDose_MedicineAmount] [nvarchar](10) NULL,
	[DefinedDailyDose_Union] [nvarchar](4) NULL,
	[DefinedDailyDose_AmountInPackage] [nvarchar](18) NULL,
	[WHO_Index] [nvarchar](8) NULL,
	[MedicalSubstances] [nvarchar](2000) NULL,
	[Dispensing] [nvarchar](300) NULL,
	[Addiction] [nvarchar](4) NULL,
	[Doping] [nvarchar](300) NULL,
	[NarVla] [nvarchar](2) NULL,
	[SuppliedPast_HalfYear] [nvarchar](2) NULL,
	[Ean] [nvarchar](10) NULL,
	[Braille] [nvarchar](4) NULL,
	[Expiration] [nvarchar](5) NULL,
	[Expoiration_Type] [nvarchar](5) NULL,
	[RegisteredName] [nvarchar](255) NULL,
	[MRP_Number] [nvarchar](15) NULL,
	[LegalRegistrationBase] [nvarchar](8) NULL,
	[ProtectiveElement] [nvarchar](2) NULL,
	[Problem] [nvarchar](10) NULL,
 CONSTRAINT [PK_MedicinePills] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE FULLTEXT INDEX ON  [dbo].[MedicinePills] (
    Name LANGUAGE 1029,
    SUKL_Code LANGUAGE 1029,
    RegistrationHolder LANGUAGE 1029,
    ATC LANGUAGE 1029,
    MedicalSubstances LANGUAGE 1029,
    Dispensing LANGUAGE 1029
) KEY INDEX PK_MedicinePills 
ON MedicineFullTextCatalog
WITH 
    CHANGE_TRACKING = AUTO, 
    STOPLIST = OFF
;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicineSPC_Mapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MedicineSUKL] [nvarchar](7) NOT NULL,
	[DocumentName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_MedicineSPC_Mapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pharmacist](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PharmacyId] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Surname] [nvarchar](255) NULL,
	[TitleBefore] [nvarchar](50) NULL,
	[TitleAfter] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pharmacy](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[WorkPlaceCode] [nvarchar](100) NULL,
	[PharmacyCode] [nvarchar](100) NULL,
	[Icz] [nvarchar](50) NULL,
	[Ico] [nvarchar](40) NULL,
	[PharmacyType] [nvarchar](100) NULL,
	[Latitude] [nvarchar](15) NULL,
	[Longitude] [nvarchar](15) NULL,
	[HasEmergency] [bit] NULL,
	[ExtendedWorkTime] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PharmacyAddress](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PharmacyId] [int] NOT NULL,
	[City] [nvarchar](255) NULL,
	[Street] [nvarchar](255) NULL,
	[OrientationNumber] [nvarchar](25) NULL,
	[DescriptiveNumber] [nvarchar](25) NULL,
	[Psc] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PharmacyEmail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[PharmacyId] [int] NOT NULL,
 CONSTRAINT [PK_PharmacyEmail] PRIMARY KEY CLUSTERED 
(
	[Email] ASC,
	[PharmacyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PharmacyOpeningHours](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PharmacyId] [int] NOT NULL,
	[Day] [nvarchar](10) NOT NULL,
	[Time] [nvarchar](25) NULL,
 CONSTRAINT [PK_PharmacyWeb] PRIMARY KEY CLUSTERED 
(
	[Day] ASC,
	[PharmacyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PharmacyPhone](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Phone] [nvarchar](100) NOT NULL,
	[PharmacyId] [int] NOT NULL,
 CONSTRAINT [PK_PharmacyPhone] PRIMARY KEY CLUSTERED 
(
	[Phone] ASC,
	[PharmacyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PharmacyWeb](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Web] [nvarchar](255) NOT NULL,
	[PharmacyId] [int] NOT NULL,
 CONSTRAINT [PK_PharmacyOpeninhHours] PRIMARY KEY CLUSTERED 
(
	[Web] ASC,
	[PharmacyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SPCDocuments]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SPCDocuments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](255) NOT NULL,
	[FileType] [nvarchar](50) NOT NULL,
	[FileContent] [varbinary](max) NOT NULL,
	[Size] [nvarchar](80) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_SPCDocuments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StructuredMedicineDocuments]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StructuredMedicineDocuments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DocumentName] [nvarchar](255) NULL,
	[Indications] [nvarchar](max) NULL,
	[Contraindications] [nvarchar](max) NULL,
	[SideEffects] [nvarchar](max) NULL,
	[Validity] [nvarchar](max) NULL,
	[Warnings] [nvarchar](max) NULL,
	[Interactions] [nvarchar](max) NULL,
	[Dosage] [nvarchar](max) NULL,
	[Compositions] [nvarchar](max) NULL,
	[Substances] [nvarchar](max) NULL,
	[Overdose] [nvarchar](max) NULL,
 CONSTRAINT [PK_StructuredMedicineDocuments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE FULLTEXT INDEX ON  [dbo].[StructuredMedicineDocuments] (
    Indications LANGUAGE 1029,
    Contraindications LANGUAGE 1029,
    SideEffects LANGUAGE 1029,
    Validity LANGUAGE 1029,
    Warnings LANGUAGE 1029,
    Interactions LANGUAGE 1029,
    Dosage LANGUAGE 1029,
    Compositions LANGUAGE 1029,
    Substances LANGUAGE 1029,
    Overdose LANGUAGE 1029
) KEY INDEX PK_StructuredMedicineDocuments 
ON DocumentFullTextCatalog
WITH 
    CHANGE_TRACKING = AUTO, 
    STOPLIST=OFF
;
GO
ALTER TABLE [dbo].[SPCDocuments] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Pharmacist]  WITH CHECK ADD  CONSTRAINT [PK_Pharmacist_Pharmacy] FOREIGN KEY([PharmacyId])
REFERENCES [dbo].[Pharmacy] ([Id])
GO
ALTER TABLE [dbo].[Pharmacist] CHECK CONSTRAINT [PK_Pharmacist_Pharmacy]
GO
ALTER TABLE [dbo].[PharmacyAddress]  WITH CHECK ADD  CONSTRAINT [PK_PharmacyAddress_Pharmacy] FOREIGN KEY([PharmacyId])
REFERENCES [dbo].[Pharmacy] ([Id])
GO
ALTER TABLE [dbo].[PharmacyAddress] CHECK CONSTRAINT [PK_PharmacyAddress_Pharmacy]
GO
ALTER TABLE [dbo].[PharmacyEmail]  WITH CHECK ADD  CONSTRAINT [PK_PharmacyEmail_Pharmacy] FOREIGN KEY([PharmacyId])
REFERENCES [dbo].[Pharmacy] ([Id])
GO
ALTER TABLE [dbo].[PharmacyEmail] CHECK CONSTRAINT [PK_PharmacyEmail_Pharmacy]
GO
ALTER TABLE [dbo].[PharmacyOpeningHours]  WITH CHECK ADD  CONSTRAINT [PK_PharmacyOpeninhHours_Pharmacy] FOREIGN KEY([PharmacyId])
REFERENCES [dbo].[Pharmacy] ([Id])
GO
ALTER TABLE [dbo].[PharmacyOpeningHours] CHECK CONSTRAINT [PK_PharmacyOpeninhHours_Pharmacy]
GO
ALTER TABLE [dbo].[PharmacyPhone]  WITH CHECK ADD  CONSTRAINT [PK_PharmacyPhone_Pharmacy] FOREIGN KEY([PharmacyId])
REFERENCES [dbo].[Pharmacy] ([Id])
GO
ALTER TABLE [dbo].[PharmacyPhone] CHECK CONSTRAINT [PK_PharmacyPhone_Pharmacy]
GO
ALTER TABLE [dbo].[PharmacyWeb]  WITH CHECK ADD  CONSTRAINT [PK_PharmacyWeb_Pharmacy] FOREIGN KEY([PharmacyId])
REFERENCES [dbo].[Pharmacy] ([Id])
GO
ALTER TABLE [dbo].[PharmacyWeb] CHECK CONSTRAINT [PK_PharmacyWeb_Pharmacy]
GO
/****** Object:  StoredProcedure [dbo].[GetAllPharmacies]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAllPharmacies] 
AS
BEGIN
	SELECT P.[Id]
		,P.[Name]
		,IIF(([WorkPlaceCode] = '' OR [WorkPlaceCode] IS NULL), NULL, [WorkPlaceCode]) AS WorkPlaceCode
		,IIF(([PharmacyCode] = '' OR [PharmacyCode] IS NULL), NULL, [PharmacyCode]) AS PharmacyCode
		,IIF(([Icz] = '' OR [Icz] IS NULL), NULL, [Icz]) AS Icz
		,IIF(([Ico] = '' OR [Ico] IS NULL), NULL, [Ico]) AS Ico
		,IIF(([PharmacyType] = '' OR [PharmacyType] IS NULL), NULL, [PharmacyType]) AS PharmacyType
		,[Latitude]
		,[Longitude]
		,[HasEmergency]
		,[ExtendedWorkTime]
		,IIF((PA.[City] = '' OR PA.[City] IS NULL), NULL, PA.[City]) AS City
		,IIF((PA.[Street] = '' OR PA.[Street] IS NULL), NULL, PA.[Street]) AS Street
		,IIF((PA.[OrientationNumber] = '' OR PA.[OrientationNumber] IS NULL), NULL, PA.[OrientationNumber]) AS OrientationNumber
		,IIF((PA.[DescriptiveNumber] = '' OR PA.[DescriptiveNumber] IS NULL), NULL, PA.[DescriptiveNumber]) AS DescriptiveNumber
		,IIF((PA.[Psc] = '' OR PA.[Psc] IS NULL), NULL, PA.[Psc]) AS PostalCode
		,IIF((PT.[Name] = '' OR PT.[Name] IS NULL), NULL, PT.[Name]) AS PharmacistName
		,IIF((PT.[Surname] = '' OR PT.[Surname] IS NULL), NULL, PT.[Surname]) AS PharmacistSurname
		,IIF((PT.[TitleBefore] = '' OR PT.[TitleBefore] IS NULL), NULL, PT.[TitleBefore]) AS TitleBefore
		,IIF((PT.[TitleAfter] = '' OR PT.[TitleAfter] IS NULL), NULL, PT.[TitleAfter]) AS TitleAfter
	FROM [dbo].[Pharmacy] P
	LEFT JOIN [dbo].[PharmacyAddress] PA ON P.[Id] = PA.[PharmacyId]
	LEFT JOIN [dbo].[Pharmacist] PT ON P.[Id] = PT.[PharmacyId]
END
GO
/****** Object:  StoredProcedure [dbo].[GetMedicinePillsByComposition]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetMedicinePillsByComposition] 
	@searchText NVARCHAR(300) = NULL,
	@topN INT,
	@healthConditions NVARCHAR(700) = NULL
AS
BEGIN
	DECLARE @condition NVARCHAR(400) = CONCAT('FORMSOF(FREETEXT,"',@searchText,'" )')

	IF @healthConditions IS NULL
	BEGIN
		SELECT TOP (@topN) MP.[Id]
			,[SUKL_Code]
			,[Name] AS MedicineName
			,IIF([MedicalPower] != '', [MedicalPower], NULL) AS MedicalPower
			,IIF([Form] != '', [Form], NULL) AS Form
			,IIF([Packing] != '', [Packing], NULL) AS Packing
			,IIF([WayOfUse] != '', [WayOfUse], NULL) AS WayOfUse
			,IIF([Supplement] != '', [Supplement], NULL) AS Supplement
			,IIF([Cover] != '', [Cover], NULL) AS Cover
			,IIF([RegistrationHolder] != '', [RegistrationHolder], NULL) AS RegistrationHolder
			,IIF([HolderCountry] != '', [HolderCountry], NULL) AS HolderCountry
			,IIF([RegistrationState] != '', [RegistrationState], NULL) AS RegistrationState
			,IIF([RegistrationValidTo_DDMMYY] != '', [RegistrationValidTo_DDMMYY], NULL) AS RegistrationValidTo_DDMMYY
			,IIF([UnlimitedRegistration] != '', [UnlimitedRegistration], NULL) AS UnlimitedRegistration
			,IIF([IndicationGroup] != '', [IndicationGroup], NULL) AS IndicationGroup
			,IIF([ATC] != '', [ATC], NULL) AS ATC
			,IIF([ATC_Name] != '', [ATC_Name], NULL) AS ATC_Name
			,IIF([RegistrationNumber] != '', [RegistrationNumber], NULL) AS RegistrationNumber
			,IIF([RegistrationProcedure] != '', [RegistrationProcedure], NULL) AS RegistrationProcedure
			,IIF([WHO_Index] != '', [WHO_Index], NULL) AS WHO_Index
			,IIF([MedicalSubstances] != '', [MedicalSubstances], NULL) AS MedicalSubstances
			,IIF([Dispensing] != '', [Dispensing], NULL) AS Dispensing
			,IIF([Doping] != '', [Doping], NULL) AS Doping
			,IIF([Expiration] != '', [Expiration], NULL) AS Expiration
			,IIF([Expoiration_Type] != '', [Expoiration_Type], NULL) AS Expoiration_Type
			,IIF([RegisteredName] != '', [RegisteredName], NULL) AS RegisteredName
			,[Problem] as Problem
			,IIF(SMD.[DocumentName] != '', SMD.[DocumentName], NULL) AS DocumentName
			,IIF(SMD.[Indications] != '', SMD.[Indications], NULL) AS Indications 
			,IIF(SMD.[Contraindications] != '', SMD.[Contraindications], NULL) AS Contraindications
			,IIF(SMD.[SideEffects] != '', SMD.[SideEffects], NULL) AS SideEffects
			,IIF(SMD.[Validity] != '', SMD.[Validity], NULL) AS Applicability
			,IIF(SMD.[Warnings] != '', SMD.[Warnings], NULL) AS Warnings
			,IIF(SMD.[Interactions] != '', SMD.[Interactions], NULL) AS Interactions
			,IIF(SMD.[Dosage] != '', SMD.[Dosage], NULL) AS Dosage
			,IIF(SMD.[Compositions] != '', SMD.[Compositions], NULL) AS Compositions
			,IIF(SMD.[Substances] != '', SMD.[Substances], NULL) AS Substances
			,IIF(SMD.[Overdose] != '', SMD.[Overdose], NULL) AS Overdose
			,IIF(SPC.[FileType] != '', SPC.[FileType], NULL) AS FileType
			,IIF(SPC.[FileContent] != '', SPC.[FileContent], NULL) AS FileContent
			,IIF(SPC.[Size] != '', SPC.[Size], NULL) AS Size
			,IIF(SPC.[CreatedOn] != '', SPC.[CreatedOn], NULL) AS CreatedOn
		FROM [dbo].[MedicinePills] MP
		LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
		LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
		INNER JOIN CONTAINSTABLE([dbo].[StructuredMedicineDocuments], ([Compositions], [Substances]), @condition) AS S ON S.[Key] = SMD.[Id]
		--INNER JOIN FREETEXTTABLE([dbo].[StructuredMedicineDocuments], ([Compositions], [Substances]), @searchText, 1029) AS S ON S.[Key] = SMD.Id
		LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
		ORDER BY S.[RANK] DESC, [Name]
	END
	ELSE
	BEGIN
		SELECT TOP (@topN) MP.[Id]
			,[SUKL_Code]
			,[Name] AS MedicineName
			,IIF([MedicalPower] != '', [MedicalPower], NULL) AS MedicalPower
			,IIF([Form] != '', [Form], NULL) AS Form
			,IIF([Packing] != '', [Packing], NULL) AS Packing
			,IIF([WayOfUse] != '', [WayOfUse], NULL) AS WayOfUse
			,IIF([Supplement] != '', [Supplement], NULL) AS Supplement
			,IIF([Cover] != '', [Cover], NULL) AS Cover
			,IIF([RegistrationHolder] != '', [RegistrationHolder], NULL) AS RegistrationHolder
			,IIF([HolderCountry] != '', [HolderCountry], NULL) AS HolderCountry
			,IIF([RegistrationState] != '', [RegistrationState], NULL) AS RegistrationState
			,IIF([RegistrationValidTo_DDMMYY] != '', [RegistrationValidTo_DDMMYY], NULL) AS RegistrationValidTo_DDMMYY
			,IIF([UnlimitedRegistration] != '', [UnlimitedRegistration], NULL) AS UnlimitedRegistration
			,IIF([IndicationGroup] != '', [IndicationGroup], NULL) AS IndicationGroup
			,IIF([ATC] != '', [ATC], NULL) AS ATC
			,IIF([ATC_Name] != '', [ATC_Name], NULL) AS ATC_Name
			,IIF([RegistrationNumber] != '', [RegistrationNumber], NULL) AS RegistrationNumber
			,IIF([RegistrationProcedure] != '', [RegistrationProcedure], NULL) AS RegistrationProcedure
			,IIF([WHO_Index] != '', [WHO_Index], NULL) AS WHO_Index
			,IIF([MedicalSubstances] != '', [MedicalSubstances], NULL) AS MedicalSubstances
			,IIF([Dispensing] != '', [Dispensing], NULL) AS Dispensing
			,IIF([Doping] != '', [Doping], NULL) AS Doping
			,IIF([Expiration] != '', [Expiration], NULL) AS Expiration
			,IIF([Expoiration_Type] != '', [Expoiration_Type], NULL) AS Expoiration_Type
			,IIF([RegisteredName] != '', [RegisteredName], NULL) AS RegisteredName
			,[Problem] = CASE
				WHEN MP.[Id] IN (
					SELECT MP.[Id]
					FROM [dbo].[MedicinePills] MP
					LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
					LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
					LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
					WHERE CONTAINS(([Contraindications], [Substances]), @healthConditions)
				) THEN 'X'
				ELSE NULL 
			END 
			,IIF(SMD.[DocumentName] != '', SMD.[DocumentName], NULL) AS DocumentName
			,IIF(SMD.[Indications] != '', SMD.[Indications], NULL) AS Indications 
			,IIF(SMD.[Contraindications] != '', SMD.[Contraindications], NULL) AS Contraindications
			,IIF(SMD.[SideEffects] != '', SMD.[SideEffects], NULL) AS SideEffects
			,IIF(SMD.[Validity] != '', SMD.[Validity], NULL) AS Applicability
			,IIF(SMD.[Warnings] != '', SMD.[Warnings], NULL) AS Warnings
			,IIF(SMD.[Interactions] != '', SMD.[Interactions], NULL) AS Interactions
			,IIF(SMD.[Dosage] != '', SMD.[Dosage], NULL) AS Dosage
			,IIF(SMD.[Compositions] != '', SMD.[Compositions], NULL) AS Compositions
			,IIF(SMD.[Substances] != '', SMD.[Substances], NULL) AS Substances
			,IIF(SMD.[Overdose] != '', SMD.[Overdose], NULL) AS Overdose
			,IIF(SPC.[FileType] != '', SPC.[FileType], NULL) AS FileType
			,IIF(SPC.[FileContent] != '', SPC.[FileContent], NULL) AS FileContent
			,IIF(SPC.[Size] != '', SPC.[Size], NULL) AS Size
			,IIF(SPC.[CreatedOn] != '', SPC.[CreatedOn], NULL) AS CreatedOn
		FROM [dbo].[MedicinePills] MP
		LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
		LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
		INNER JOIN CONTAINSTABLE([dbo].[StructuredMedicineDocuments], ([Compositions], [Substances]), @condition) AS S ON S.[Key] = SMD.[Id]
		--INNER JOIN FREETEXTTABLE([dbo].[StructuredMedicineDocuments], ([Compositions], [Substances]), @searchText, 1029) AS S ON S.[Key] = SMD.Id
		LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
		ORDER BY S.[RANK] DESC, [Name]
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetMedicinePillsByContraindications]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetMedicinePillsByContraindications] 
	@searchText NVARCHAR(300) = NULL,
	@topN INT,
	@healthConditions NVARCHAR(700) = NULL
AS
BEGIN
	DECLARE @condition NVARCHAR(400) = CONCAT('FORMSOF(FREETEXT,"',@searchText,'" )')


	IF @healthConditions IS NULL
	BEGIN
		SELECT TOP (@topN) MP.[Id]
			,[SUKL_Code]
			,[Name] AS MedicineName
			,IIF([MedicalPower] != '', [MedicalPower], NULL) AS MedicalPower
			,IIF([Form] != '', [Form], NULL) AS Form
			,IIF([Packing] != '', [Packing], NULL) AS Packing
			,IIF([WayOfUse] != '', [WayOfUse], NULL) AS WayOfUse
			,IIF([Supplement] != '', [Supplement], NULL) AS Supplement
			,IIF([Cover] != '', [Cover], NULL) AS Cover
			,IIF([RegistrationHolder] != '', [RegistrationHolder], NULL) AS RegistrationHolder
			,IIF([HolderCountry] != '', [HolderCountry], NULL) AS HolderCountry
			,IIF([RegistrationState] != '', [RegistrationState], NULL) AS RegistrationState
			,IIF([RegistrationValidTo_DDMMYY] != '', [RegistrationValidTo_DDMMYY], NULL) AS RegistrationValidTo_DDMMYY
			,IIF([UnlimitedRegistration] != '', [UnlimitedRegistration], NULL) AS UnlimitedRegistration
			,IIF([IndicationGroup] != '', [IndicationGroup], NULL) AS IndicationGroup
			,IIF([ATC] != '', [ATC], NULL) AS ATC
			,IIF([ATC_Name] != '', [ATC_Name], NULL) AS ATC_Name
			,IIF([RegistrationNumber] != '', [RegistrationNumber], NULL) AS RegistrationNumber
			,IIF([RegistrationProcedure] != '', [RegistrationProcedure], NULL) AS RegistrationProcedure
			,IIF([WHO_Index] != '', [WHO_Index], NULL) AS WHO_Index
			,IIF([MedicalSubstances] != '', [MedicalSubstances], NULL) AS MedicalSubstances
			,IIF([Dispensing] != '', [Dispensing], NULL) AS Dispensing
			,IIF([Doping] != '', [Doping], NULL) AS Doping
			,IIF([Expiration] != '', [Expiration], NULL) AS Expiration
			,IIF([Expoiration_Type] != '', [Expoiration_Type], NULL) AS Expoiration_Type
			,IIF([RegisteredName] != '', [RegisteredName], NULL) AS RegisteredName
			,[Problem] as Problem
			,IIF(SMD.[DocumentName] != '', SMD.[DocumentName], NULL) AS DocumentName
			,IIF(SMD.[Indications] != '', SMD.[Indications], NULL) AS Indications 
			,IIF(SMD.[Contraindications] != '', SMD.[Contraindications], NULL) AS Contraindications
			,IIF(SMD.[SideEffects] != '', SMD.[SideEffects], NULL) AS SideEffects
			,IIF(SMD.[Validity] != '', SMD.[Validity], NULL) AS Applicability
			,IIF(SMD.[Warnings] != '', SMD.[Warnings], NULL) AS Warnings
			,IIF(SMD.[Interactions] != '', SMD.[Interactions], NULL) AS Interactions
			,IIF(SMD.[Dosage] != '', SMD.[Dosage], NULL) AS Dosage
			,IIF(SMD.[Compositions] != '', SMD.[Compositions], NULL) AS Compositions
			,IIF(SMD.[Substances] != '', SMD.[Substances], NULL) AS Substances
			,IIF(SMD.[Overdose] != '', SMD.[Overdose], NULL) AS Overdose
			,IIF(SPC.[FileType] != '', SPC.[FileType], NULL) AS FileType
			,IIF(SPC.[FileContent] != '', SPC.[FileContent], NULL) AS FileContent
			,IIF(SPC.[Size] != '', SPC.[Size], NULL) AS Size
			,IIF(SPC.[CreatedOn] != '', SPC.[CreatedOn], NULL) AS CreatedOn
		FROM [dbo].[MedicinePills] MP
		LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
		LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
		INNER JOIN CONTAINSTABLE([dbo].[StructuredMedicineDocuments], [Contraindications], @condition) AS S ON S.[Key] = SMD.[Id]
		--INNER JOIN FREETEXTTABLE([dbo].[StructuredMedicineDocuments], [Contraindications], @searchText, 1029) AS S ON S.[Key] = SMD.Id
		LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
		ORDER BY S.[RANK] DESC, [Name]
	END
	ELSE
	BEGIN
		SELECT TOP (@topN) MP.[Id]
			,[SUKL_Code]
			,[Name] AS MedicineName
			,IIF([MedicalPower] != '', [MedicalPower], NULL) AS MedicalPower
			,IIF([Form] != '', [Form], NULL) AS Form
			,IIF([Packing] != '', [Packing], NULL) AS Packing
			,IIF([WayOfUse] != '', [WayOfUse], NULL) AS WayOfUse
			,IIF([Supplement] != '', [Supplement], NULL) AS Supplement
			,IIF([Cover] != '', [Cover], NULL) AS Cover
			,IIF([RegistrationHolder] != '', [RegistrationHolder], NULL) AS RegistrationHolder
			,IIF([HolderCountry] != '', [HolderCountry], NULL) AS HolderCountry
			,IIF([RegistrationState] != '', [RegistrationState], NULL) AS RegistrationState
			,IIF([RegistrationValidTo_DDMMYY] != '', [RegistrationValidTo_DDMMYY], NULL) AS RegistrationValidTo_DDMMYY
			,IIF([UnlimitedRegistration] != '', [UnlimitedRegistration], NULL) AS UnlimitedRegistration
			,IIF([IndicationGroup] != '', [IndicationGroup], NULL) AS IndicationGroup
			,IIF([ATC] != '', [ATC], NULL) AS ATC
			,IIF([ATC_Name] != '', [ATC_Name], NULL) AS ATC_Name
			,IIF([RegistrationNumber] != '', [RegistrationNumber], NULL) AS RegistrationNumber
			,IIF([RegistrationProcedure] != '', [RegistrationProcedure], NULL) AS RegistrationProcedure
			,IIF([WHO_Index] != '', [WHO_Index], NULL) AS WHO_Index
			,IIF([MedicalSubstances] != '', [MedicalSubstances], NULL) AS MedicalSubstances
			,IIF([Dispensing] != '', [Dispensing], NULL) AS Dispensing
			,IIF([Doping] != '', [Doping], NULL) AS Doping
			,IIF([Expiration] != '', [Expiration], NULL) AS Expiration
			,IIF([Expoiration_Type] != '', [Expoiration_Type], NULL) AS Expoiration_Type
			,IIF([RegisteredName] != '', [RegisteredName], NULL) AS RegisteredName
			,[Problem] = CASE
				WHEN MP.[Id] IN (
					SELECT MP.[Id]
					FROM [dbo].[MedicinePills] MP
					LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
					LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
					LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
					WHERE CONTAINS(([Contraindications], [Substances]), @healthConditions)
				) THEN 'X'
				ELSE NULL 
			END 
			,IIF(SMD.[DocumentName] != '', SMD.[DocumentName], NULL) AS DocumentName
			,IIF(SMD.[Indications] != '', SMD.[Indications], NULL) AS Indications 
			,IIF(SMD.[Contraindications] != '', SMD.[Contraindications], NULL) AS Contraindications
			,IIF(SMD.[SideEffects] != '', SMD.[SideEffects], NULL) AS SideEffects
			,IIF(SMD.[Validity] != '', SMD.[Validity], NULL) AS Applicability
			,IIF(SMD.[Warnings] != '', SMD.[Warnings], NULL) AS Warnings
			,IIF(SMD.[Interactions] != '', SMD.[Interactions], NULL) AS Interactions
			,IIF(SMD.[Dosage] != '', SMD.[Dosage], NULL) AS Dosage
			,IIF(SMD.[Compositions] != '', SMD.[Compositions], NULL) AS Compositions
			,IIF(SMD.[Substances] != '', SMD.[Substances], NULL) AS Substances
			,IIF(SMD.[Overdose] != '', SMD.[Overdose], NULL) AS Overdose
			,IIF(SPC.[FileType] != '', SPC.[FileType], NULL) AS FileType
			,IIF(SPC.[FileContent] != '', SPC.[FileContent], NULL) AS FileContent
			,IIF(SPC.[Size] != '', SPC.[Size], NULL) AS Size
			,IIF(SPC.[CreatedOn] != '', SPC.[CreatedOn], NULL) AS CreatedOn
		FROM [dbo].[MedicinePills] MP
		LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
		LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
		INNER JOIN CONTAINSTABLE([dbo].[StructuredMedicineDocuments], [Contraindications], @condition) AS S ON S.[Key] = SMD.[Id]
		--INNER JOIN FREETEXTTABLE([dbo].[StructuredMedicineDocuments], [Contraindications], @searchText, 1029) AS S ON S.[Key] = SMD.Id
		LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
		ORDER BY S.[RANK] DESC, [Name]
	END

	
END
GO
/****** Object:  StoredProcedure [dbo].[GetMedicinePillsByIndications]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetMedicinePillsByIndications] 
	@searchText NVARCHAR(300) = NULL,
	@topN INT,
	@healthConditions NVARCHAR(700) = NULL
AS
BEGIN
	DECLARE @condition NVARCHAR(400) = CONCAT('FORMSOF(FREETEXT,"',@searchText,'" )')


	IF @healthConditions IS NULL
	BEGIN
		SELECT TOP (@topN) MP.[Id]
			,[SUKL_Code]
			,[Name] AS MedicineName
			,IIF([MedicalPower] != '', [MedicalPower], NULL) AS MedicalPower
			,IIF([Form] != '', [Form], NULL) AS Form
			,IIF([Packing] != '', [Packing], NULL) AS Packing
			,IIF([WayOfUse] != '', [WayOfUse], NULL) AS WayOfUse
			,IIF([Supplement] != '', [Supplement], NULL) AS Supplement
			,IIF([Cover] != '', [Cover], NULL) AS Cover
			,IIF([RegistrationHolder] != '', [RegistrationHolder], NULL) AS RegistrationHolder
			,IIF([HolderCountry] != '', [HolderCountry], NULL) AS HolderCountry
			,IIF([RegistrationState] != '', [RegistrationState], NULL) AS RegistrationState
			,IIF([RegistrationValidTo_DDMMYY] != '', [RegistrationValidTo_DDMMYY], NULL) AS RegistrationValidTo_DDMMYY
			,IIF([UnlimitedRegistration] != '', [UnlimitedRegistration], NULL) AS UnlimitedRegistration
			,IIF([IndicationGroup] != '', [IndicationGroup], NULL) AS IndicationGroup
			,IIF([ATC] != '', [ATC], NULL) AS ATC
			,IIF([ATC_Name] != '', [ATC_Name], NULL) AS ATC_Name
			,IIF([RegistrationNumber] != '', [RegistrationNumber], NULL) AS RegistrationNumber
			,IIF([RegistrationProcedure] != '', [RegistrationProcedure], NULL) AS RegistrationProcedure
			,IIF([WHO_Index] != '', [WHO_Index], NULL) AS WHO_Index
			,IIF([MedicalSubstances] != '', [MedicalSubstances], NULL) AS MedicalSubstances
			,IIF([Dispensing] != '', [Dispensing], NULL) AS Dispensing
			,IIF([Doping] != '', [Doping], NULL) AS Doping
			,IIF([Expiration] != '', [Expiration], NULL) AS Expiration
			,IIF([Expoiration_Type] != '', [Expoiration_Type], NULL) AS Expoiration_Type
			,IIF([RegisteredName] != '', [RegisteredName], NULL) AS RegisteredName
			,[Problem] as Problem
			,IIF(SMD.[DocumentName] != '', SMD.[DocumentName], NULL) AS DocumentName
			,IIF(SMD.[Indications] != '', SMD.[Indications], NULL) AS Indications 
			,IIF(SMD.[Contraindications] != '', SMD.[Contraindications], NULL) AS Contraindications
			,IIF(SMD.[SideEffects] != '', SMD.[SideEffects], NULL) AS SideEffects
			,IIF(SMD.[Validity] != '', SMD.[Validity], NULL) AS Applicability
			,IIF(SMD.[Warnings] != '', SMD.[Warnings], NULL) AS Warnings
			,IIF(SMD.[Interactions] != '', SMD.[Interactions], NULL) AS Interactions
			,IIF(SMD.[Dosage] != '', SMD.[Dosage], NULL) AS Dosage
			,IIF(SMD.[Compositions] != '', SMD.[Compositions], NULL) AS Compositions
			,IIF(SMD.[Substances] != '', SMD.[Substances], NULL) AS Substances
			,IIF(SMD.[Overdose] != '', SMD.[Overdose], NULL) AS Overdose
			,IIF(SPC.[FileType] != '', SPC.[FileType], NULL) AS FileType
			,IIF(SPC.[FileContent] != '', SPC.[FileContent], NULL) AS FileContent
			,IIF(SPC.[Size] != '', SPC.[Size], NULL) AS Size
			,IIF(SPC.[CreatedOn] != '', SPC.[CreatedOn], NULL) AS CreatedOn
		FROM [dbo].[MedicinePills] MP
		LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
		LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
		INNER JOIN CONTAINSTABLE([dbo].[StructuredMedicineDocuments], [Indications], @condition) AS S ON S.[Key] = SMD.[Id]
		--INNER JOIN FREETEXTTABLE([dbo].[StructuredMedicineDocuments], [Indications], @searchText, 1029) AS S ON S.[Key] = SMD.Id
		LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
		ORDER BY S.[RANK] DESC, [Name]
	END
	ELSE
	BEGIN
		SELECT TOP (@topN) MP.[Id]
			,[SUKL_Code]
			,[Name] AS MedicineName
			,IIF([MedicalPower] != '', [MedicalPower], NULL) AS MedicalPower
			,IIF([Form] != '', [Form], NULL) AS Form
			,IIF([Packing] != '', [Packing], NULL) AS Packing
			,IIF([WayOfUse] != '', [WayOfUse], NULL) AS WayOfUse
			,IIF([Supplement] != '', [Supplement], NULL) AS Supplement
			,IIF([Cover] != '', [Cover], NULL) AS Cover
			,IIF([RegistrationHolder] != '', [RegistrationHolder], NULL) AS RegistrationHolder
			,IIF([HolderCountry] != '', [HolderCountry], NULL) AS HolderCountry
			,IIF([RegistrationState] != '', [RegistrationState], NULL) AS RegistrationState
			,IIF([RegistrationValidTo_DDMMYY] != '', [RegistrationValidTo_DDMMYY], NULL) AS RegistrationValidTo_DDMMYY
			,IIF([UnlimitedRegistration] != '', [UnlimitedRegistration], NULL) AS UnlimitedRegistration
			,IIF([IndicationGroup] != '', [IndicationGroup], NULL) AS IndicationGroup
			,IIF([ATC] != '', [ATC], NULL) AS ATC
			,IIF([ATC_Name] != '', [ATC_Name], NULL) AS ATC_Name
			,IIF([RegistrationNumber] != '', [RegistrationNumber], NULL) AS RegistrationNumber
			,IIF([RegistrationProcedure] != '', [RegistrationProcedure], NULL) AS RegistrationProcedure
			,IIF([WHO_Index] != '', [WHO_Index], NULL) AS WHO_Index
			,IIF([MedicalSubstances] != '', [MedicalSubstances], NULL) AS MedicalSubstances
			,IIF([Dispensing] != '', [Dispensing], NULL) AS Dispensing
			,IIF([Doping] != '', [Doping], NULL) AS Doping
			,IIF([Expiration] != '', [Expiration], NULL) AS Expiration
			,IIF([Expoiration_Type] != '', [Expoiration_Type], NULL) AS Expoiration_Type
			,IIF([RegisteredName] != '', [RegisteredName], NULL) AS RegisteredName
			,[Problem] = CASE
				WHEN MP.[Id] IN (
					SELECT MP.[Id]
					FROM [dbo].[MedicinePills] MP
					LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
					LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
					LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
					WHERE CONTAINS(([Contraindications], [Substances]), @healthConditions)
				) THEN 'X'
				ELSE NULL 
			END 
			,IIF(SMD.[DocumentName] != '', SMD.[DocumentName], NULL) AS DocumentName
			,IIF(SMD.[Indications] != '', SMD.[Indications], NULL) AS Indications 
			,IIF(SMD.[Contraindications] != '', SMD.[Contraindications], NULL) AS Contraindications
			,IIF(SMD.[SideEffects] != '', SMD.[SideEffects], NULL) AS SideEffects
			,IIF(SMD.[Validity] != '', SMD.[Validity], NULL) AS Applicability
			,IIF(SMD.[Warnings] != '', SMD.[Warnings], NULL) AS Warnings
			,IIF(SMD.[Interactions] != '', SMD.[Interactions], NULL) AS Interactions
			,IIF(SMD.[Dosage] != '', SMD.[Dosage], NULL) AS Dosage
			,IIF(SMD.[Compositions] != '', SMD.[Compositions], NULL) AS Compositions
			,IIF(SMD.[Substances] != '', SMD.[Substances], NULL) AS Substances
			,IIF(SMD.[Overdose] != '', SMD.[Overdose], NULL) AS Overdose
			,IIF(SPC.[FileType] != '', SPC.[FileType], NULL) AS FileType
			,IIF(SPC.[FileContent] != '', SPC.[FileContent], NULL) AS FileContent
			,IIF(SPC.[Size] != '', SPC.[Size], NULL) AS Size
			,IIF(SPC.[CreatedOn] != '', SPC.[CreatedOn], NULL) AS CreatedOn
		FROM [dbo].[MedicinePills] MP
		LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
		LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
		INNER JOIN CONTAINSTABLE([dbo].[StructuredMedicineDocuments], [Indications], @condition) AS S ON S.[Key] = SMD.[Id]
		--INNER JOIN FREETEXTTABLE([dbo].[StructuredMedicineDocuments], [Indications], @searchText, 1029) AS S ON S.[Key] = SMD.Id
		LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
		ORDER BY S.[RANK] DESC, [Name]
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetMedicinePillsByInteractions]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetMedicinePillsByInteractions] 
	@searchText NVARCHAR(300) = NULL,
	@topN INT,
	@healthConditions NVARCHAR(700) = NULL
AS
BEGIN
	DECLARE @condition NVARCHAR(400) = CONCAT('FORMSOF(FREETEXT,"',@searchText,'" )')

	IF @healthConditions IS NULL
	BEGIN
		SELECT TOP (@topN) MP.[Id]
			,[SUKL_Code]
			,[Name] AS MedicineName
			,IIF([MedicalPower] != '', [MedicalPower], NULL) AS MedicalPower
			,IIF([Form] != '', [Form], NULL) AS Form
			,IIF([Packing] != '', [Packing], NULL) AS Packing
			,IIF([WayOfUse] != '', [WayOfUse], NULL) AS WayOfUse
			,IIF([Supplement] != '', [Supplement], NULL) AS Supplement
			,IIF([Cover] != '', [Cover], NULL) AS Cover
			,IIF([RegistrationHolder] != '', [RegistrationHolder], NULL) AS RegistrationHolder
			,IIF([HolderCountry] != '', [HolderCountry], NULL) AS HolderCountry
			,IIF([RegistrationState] != '', [RegistrationState], NULL) AS RegistrationState
			,IIF([RegistrationValidTo_DDMMYY] != '', [RegistrationValidTo_DDMMYY], NULL) AS RegistrationValidTo_DDMMYY
			,IIF([UnlimitedRegistration] != '', [UnlimitedRegistration], NULL) AS UnlimitedRegistration
			,IIF([IndicationGroup] != '', [IndicationGroup], NULL) AS IndicationGroup
			,IIF([ATC] != '', [ATC], NULL) AS ATC
			,IIF([ATC_Name] != '', [ATC_Name], NULL) AS ATC_Name
			,IIF([RegistrationNumber] != '', [RegistrationNumber], NULL) AS RegistrationNumber
			,IIF([RegistrationProcedure] != '', [RegistrationProcedure], NULL) AS RegistrationProcedure
			,IIF([WHO_Index] != '', [WHO_Index], NULL) AS WHO_Index
			,IIF([MedicalSubstances] != '', [MedicalSubstances], NULL) AS MedicalSubstances
			,IIF([Dispensing] != '', [Dispensing], NULL) AS Dispensing
			,IIF([Doping] != '', [Doping], NULL) AS Doping
			,IIF([Expiration] != '', [Expiration], NULL) AS Expiration
			,IIF([Expoiration_Type] != '', [Expoiration_Type], NULL) AS Expoiration_Type
			,IIF([RegisteredName] != '', [RegisteredName], NULL) AS RegisteredName
			,[Problem] as Problem
			,IIF(SMD.[DocumentName] != '', SMD.[DocumentName], NULL) AS DocumentName
			,IIF(SMD.[Indications] != '', SMD.[Indications], NULL) AS Indications 
			,IIF(SMD.[Contraindications] != '', SMD.[Contraindications], NULL) AS Contraindications
			,IIF(SMD.[SideEffects] != '', SMD.[SideEffects], NULL) AS SideEffects
			,IIF(SMD.[Validity] != '', SMD.[Validity], NULL) AS Applicability
			,IIF(SMD.[Warnings] != '', SMD.[Warnings], NULL) AS Warnings
			,IIF(SMD.[Interactions] != '', SMD.[Interactions], NULL) AS Interactions
			,IIF(SMD.[Dosage] != '', SMD.[Dosage], NULL) AS Dosage
			,IIF(SMD.[Compositions] != '', SMD.[Compositions], NULL) AS Compositions
			,IIF(SMD.[Substances] != '', SMD.[Substances], NULL) AS Substances
			,IIF(SMD.[Overdose] != '', SMD.[Overdose], NULL) AS Overdose
			,IIF(SPC.[FileType] != '', SPC.[FileType], NULL) AS FileType
			,IIF(SPC.[FileContent] != '', SPC.[FileContent], NULL) AS FileContent
			,IIF(SPC.[Size] != '', SPC.[Size], NULL) AS Size
			,IIF(SPC.[CreatedOn] != '', SPC.[CreatedOn], NULL) AS CreatedOn
		FROM [dbo].[MedicinePills] MP
		LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
		LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
		INNER JOIN CONTAINSTABLE([dbo].[StructuredMedicineDocuments], [Interactions], @condition) AS S ON S.[Key] = SMD.[Id]
		--INNER JOIN FREETEXTTABLE([dbo].[StructuredMedicineDocuments], [Interactions], @searchText, 1029) AS S ON S.[Key] = SMD.Id
		LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
		ORDER BY S.[RANK] DESC, [Name]
	END
	ELSE
	BEGIN
		SELECT TOP (@topN) MP.[Id]
			,[SUKL_Code]
			,[Name] AS MedicineName
			,IIF([MedicalPower] != '', [MedicalPower], NULL) AS MedicalPower
			,IIF([Form] != '', [Form], NULL) AS Form
			,IIF([Packing] != '', [Packing], NULL) AS Packing
			,IIF([WayOfUse] != '', [WayOfUse], NULL) AS WayOfUse
			,IIF([Supplement] != '', [Supplement], NULL) AS Supplement
			,IIF([Cover] != '', [Cover], NULL) AS Cover
			,IIF([RegistrationHolder] != '', [RegistrationHolder], NULL) AS RegistrationHolder
			,IIF([HolderCountry] != '', [HolderCountry], NULL) AS HolderCountry
			,IIF([RegistrationState] != '', [RegistrationState], NULL) AS RegistrationState
			,IIF([RegistrationValidTo_DDMMYY] != '', [RegistrationValidTo_DDMMYY], NULL) AS RegistrationValidTo_DDMMYY
			,IIF([UnlimitedRegistration] != '', [UnlimitedRegistration], NULL) AS UnlimitedRegistration
			,IIF([IndicationGroup] != '', [IndicationGroup], NULL) AS IndicationGroup
			,IIF([ATC] != '', [ATC], NULL) AS ATC
			,IIF([ATC_Name] != '', [ATC_Name], NULL) AS ATC_Name
			,IIF([RegistrationNumber] != '', [RegistrationNumber], NULL) AS RegistrationNumber
			,IIF([RegistrationProcedure] != '', [RegistrationProcedure], NULL) AS RegistrationProcedure
			,IIF([WHO_Index] != '', [WHO_Index], NULL) AS WHO_Index
			,IIF([MedicalSubstances] != '', [MedicalSubstances], NULL) AS MedicalSubstances
			,IIF([Dispensing] != '', [Dispensing], NULL) AS Dispensing
			,IIF([Doping] != '', [Doping], NULL) AS Doping
			,IIF([Expiration] != '', [Expiration], NULL) AS Expiration
			,IIF([Expoiration_Type] != '', [Expoiration_Type], NULL) AS Expoiration_Type
			,IIF([RegisteredName] != '', [RegisteredName], NULL) AS RegisteredName
			,[Problem] = CASE
				WHEN MP.[Id] IN (
					SELECT MP.[Id]
					FROM [dbo].[MedicinePills] MP
					LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
					LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
					LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
					WHERE CONTAINS(([Contraindications], [Substances]), @healthConditions)
				) THEN 'X'
				ELSE NULL 
			END 
			,IIF(SMD.[DocumentName] != '', SMD.[DocumentName], NULL) AS DocumentName
			,IIF(SMD.[Indications] != '', SMD.[Indications], NULL) AS Indications 
			,IIF(SMD.[Contraindications] != '', SMD.[Contraindications], NULL) AS Contraindications
			,IIF(SMD.[SideEffects] != '', SMD.[SideEffects], NULL) AS SideEffects
			,IIF(SMD.[Validity] != '', SMD.[Validity], NULL) AS Applicability
			,IIF(SMD.[Warnings] != '', SMD.[Warnings], NULL) AS Warnings
			,IIF(SMD.[Interactions] != '', SMD.[Interactions], NULL) AS Interactions
			,IIF(SMD.[Dosage] != '', SMD.[Dosage], NULL) AS Dosage
			,IIF(SMD.[Compositions] != '', SMD.[Compositions], NULL) AS Compositions
			,IIF(SMD.[Substances] != '', SMD.[Substances], NULL) AS Substances
			,IIF(SMD.[Overdose] != '', SMD.[Overdose], NULL) AS Overdose
			,IIF(SPC.[FileType] != '', SPC.[FileType], NULL) AS FileType
			,IIF(SPC.[FileContent] != '', SPC.[FileContent], NULL) AS FileContent
			,IIF(SPC.[Size] != '', SPC.[Size], NULL) AS Size
			,IIF(SPC.[CreatedOn] != '', SPC.[CreatedOn], NULL) AS CreatedOn
		FROM [dbo].[MedicinePills] MP
		LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
		LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
		INNER JOIN CONTAINSTABLE([dbo].[StructuredMedicineDocuments], [Interactions], @condition) AS S ON S.[Key] = SMD.[Id]
		--INNER JOIN FREETEXTTABLE([dbo].[StructuredMedicineDocuments], [Interactions], @searchText, 1029) AS S ON S.[Key] = SMD.Id
		LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
		ORDER BY S.[RANK] DESC, [Name]
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetMedicinePillsByMedicalSubstances]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetMedicinePillsByMedicalSubstances] 
	@searchText NVARCHAR(300) = NULL,
	@topN INT,
	@healthConditions NVARCHAR(700) = NULL
AS
BEGIN
	DECLARE @condition NVARCHAR(400) = CONCAT('"',@searchText,'"')
	
	IF @healthConditions IS NULL
	BEGIN
		SELECT TOP (@topN) MP.[Id]
			,[SUKL_Code]
			,[Name] AS MedicineName
			,IIF([MedicalPower] != '', [MedicalPower], NULL) AS MedicalPower
			,IIF([Form] != '', [Form], NULL) AS Form
			,IIF([Packing] != '', [Packing], NULL) AS Packing
			,IIF([WayOfUse] != '', [WayOfUse], NULL) AS WayOfUse
			,IIF([Supplement] != '', [Supplement], NULL) AS Supplement
			,IIF([Cover] != '', [Cover], NULL) AS Cover
			,IIF([RegistrationHolder] != '', [RegistrationHolder], NULL) AS RegistrationHolder
			,IIF([HolderCountry] != '', [HolderCountry], NULL) AS HolderCountry
			,IIF([RegistrationState] != '', [RegistrationState], NULL) AS RegistrationState
			,IIF([RegistrationValidTo_DDMMYY] != '', [RegistrationValidTo_DDMMYY], NULL) AS RegistrationValidTo_DDMMYY
			,IIF([UnlimitedRegistration] != '', [UnlimitedRegistration], NULL) AS UnlimitedRegistration
			,IIF([IndicationGroup] != '', [IndicationGroup], NULL) AS IndicationGroup
			,IIF([ATC] != '', [ATC], NULL) AS ATC
			,IIF([ATC_Name] != '', [ATC_Name], NULL) AS ATC_Name
			,IIF([RegistrationNumber] != '', [RegistrationNumber], NULL) AS RegistrationNumber
			,IIF([RegistrationProcedure] != '', [RegistrationProcedure], NULL) AS RegistrationProcedure
			,IIF([WHO_Index] != '', [WHO_Index], NULL) AS WHO_Index
			,IIF([MedicalSubstances] != '', [MedicalSubstances], NULL) AS MedicalSubstances
			,IIF([Dispensing] != '', [Dispensing], NULL) AS Dispensing
			,IIF([Doping] != '', [Doping], NULL) AS Doping
			,IIF([Expiration] != '', [Expiration], NULL) AS Expiration
			,IIF([Expoiration_Type] != '', [Expoiration_Type], NULL) AS Expoiration_Type
			,IIF([RegisteredName] != '', [RegisteredName], NULL) AS RegisteredName
			,[Problem] as Problem
			,IIF(SMD.[DocumentName] != '', SMD.[DocumentName], NULL) AS DocumentName
			,IIF(SMD.[Indications] != '', SMD.[Indications], NULL) AS Indications 
			,IIF(SMD.[Contraindications] != '', SMD.[Contraindications], NULL) AS Contraindications
			,IIF(SMD.[SideEffects] != '', SMD.[SideEffects], NULL) AS SideEffects
			,IIF(SMD.[Validity] != '', SMD.[Validity], NULL) AS Applicability
			,IIF(SMD.[Warnings] != '', SMD.[Warnings], NULL) AS Warnings
			,IIF(SMD.[Interactions] != '', SMD.[Interactions], NULL) AS Interactions
			,IIF(SMD.[Dosage] != '', SMD.[Dosage], NULL) AS Dosage
			,IIF(SMD.[Compositions] != '', SMD.[Compositions], NULL) AS Compositions
			,IIF(SMD.[Substances] != '', SMD.[Substances], NULL) AS Substances
			,IIF(SMD.[Overdose] != '', SMD.[Overdose], NULL) AS Overdose
			,IIF(SPC.[FileType] != '', SPC.[FileType], NULL) AS FileType
			,IIF(SPC.[FileContent] != '', SPC.[FileContent], NULL) AS FileContent
			,IIF(SPC.[Size] != '', SPC.[Size], NULL) AS Size
			,IIF(SPC.[CreatedOn] != '', SPC.[CreatedOn], NULL) AS CreatedOn
		FROM [dbo].[MedicinePills] MP
		LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
		LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
		INNER JOIN CONTAINSTABLE([dbo].[MedicinePills], [MedicalSubstances], @condition) AS S ON S.[Key] = MP.[Id]
		--INNER JOIN FREETEXTTABLE([dbo].[MedicinePills], [Name], @searchText, 1029) AS S ON S.[Key] = MP.Id
		LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
		--WHERE MP.[Name] LIKE '%' + @searchText + '%'
		ORDER BY S.[RANK] DESC, MP.[Name]
	END
	ELSE
	BEGIN
		SELECT TOP (@topN) MP.[Id]
			,[SUKL_Code]
			,[Name] AS MedicineName
			,IIF([MedicalPower] != '', [MedicalPower], NULL) AS MedicalPower
			,IIF([Form] != '', [Form], NULL) AS Form
			,IIF([Packing] != '', [Packing], NULL) AS Packing
			,IIF([WayOfUse] != '', [WayOfUse], NULL) AS WayOfUse
			,IIF([Supplement] != '', [Supplement], NULL) AS Supplement
			,IIF([Cover] != '', [Cover], NULL) AS Cover
			,IIF([RegistrationHolder] != '', [RegistrationHolder], NULL) AS RegistrationHolder
			,IIF([HolderCountry] != '', [HolderCountry], NULL) AS HolderCountry
			,IIF([RegistrationState] != '', [RegistrationState], NULL) AS RegistrationState
			,IIF([RegistrationValidTo_DDMMYY] != '', [RegistrationValidTo_DDMMYY], NULL) AS RegistrationValidTo_DDMMYY
			,IIF([UnlimitedRegistration] != '', [UnlimitedRegistration], NULL) AS UnlimitedRegistration
			,IIF([IndicationGroup] != '', [IndicationGroup], NULL) AS IndicationGroup
			,IIF([ATC] != '', [ATC], NULL) AS ATC
			,IIF([ATC_Name] != '', [ATC_Name], NULL) AS ATC_Name
			,IIF([RegistrationNumber] != '', [RegistrationNumber], NULL) AS RegistrationNumber
			,IIF([RegistrationProcedure] != '', [RegistrationProcedure], NULL) AS RegistrationProcedure
			,IIF([WHO_Index] != '', [WHO_Index], NULL) AS WHO_Index
			,IIF([MedicalSubstances] != '', [MedicalSubstances], NULL) AS MedicalSubstances
			,IIF([Dispensing] != '', [Dispensing], NULL) AS Dispensing
			,IIF([Doping] != '', [Doping], NULL) AS Doping
			,IIF([Expiration] != '', [Expiration], NULL) AS Expiration
			,IIF([Expoiration_Type] != '', [Expoiration_Type], NULL) AS Expoiration_Type
			,IIF([RegisteredName] != '', [RegisteredName], NULL) AS RegisteredName
			,[Problem] = CASE
				WHEN MP.[Id] IN (
					SELECT MP.[Id]
					FROM [dbo].[MedicinePills] MP
					LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
					LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
					LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
					WHERE CONTAINS(([Contraindications], [Substances]), @healthConditions)
				) THEN 'X'
				ELSE NULL 
			END 
			,IIF(SMD.[DocumentName] != '', SMD.[DocumentName], NULL) AS DocumentName
			,IIF(SMD.[Indications] != '', SMD.[Indications], NULL) AS Indications 
			,IIF(SMD.[Contraindications] != '', SMD.[Contraindications], NULL) AS Contraindications
			,IIF(SMD.[SideEffects] != '', SMD.[SideEffects], NULL) AS SideEffects
			,IIF(SMD.[Validity] != '', SMD.[Validity], NULL) AS Applicability
			,IIF(SMD.[Warnings] != '', SMD.[Warnings], NULL) AS Warnings
			,IIF(SMD.[Interactions] != '', SMD.[Interactions], NULL) AS Interactions
			,IIF(SMD.[Dosage] != '', SMD.[Dosage], NULL) AS Dosage
			,IIF(SMD.[Compositions] != '', SMD.[Compositions], NULL) AS Compositions
			,IIF(SMD.[Substances] != '', SMD.[Substances], NULL) AS Substances
			,IIF(SMD.[Overdose] != '', SMD.[Overdose], NULL) AS Overdose
			,IIF(SPC.[FileType] != '', SPC.[FileType], NULL) AS FileType
			,IIF(SPC.[FileContent] != '', SPC.[FileContent], NULL) AS FileContent
			,IIF(SPC.[Size] != '', SPC.[Size], NULL) AS Size
			,IIF(SPC.[CreatedOn] != '', SPC.[CreatedOn], NULL) AS CreatedOn
		FROM [dbo].[MedicinePills] MP
		LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
		LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
		INNER JOIN CONTAINSTABLE([dbo].[MedicinePills], [MedicalSubstances], @condition) AS S ON S.[Key] = MP.[Id]
		--INNER JOIN FREETEXTTABLE([dbo].[MedicinePills], [Name], @searchText, 1029) AS S ON S.[Key] = MP.Id
		LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
		--WHERE MP.[Name] LIKE '%' + @searchText + '%'
		ORDER BY S.[RANK] DESC, MP.[Name]
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetMedicinePillsByName]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetMedicinePillsByName] 
	@searchText NVARCHAR(300) = NULL,
	@topN INT,
	@healthConditions NVARCHAR(700) = NULL
AS
BEGIN
	DECLARE @condition NVARCHAR(400) = CONCAT('"',@searchText,'"')
	
	IF @healthConditions IS NULL
	BEGIN
		SELECT TOP (@topN) MP.[Id]
			,[SUKL_Code]
			,[Name] AS MedicineName
			,IIF([MedicalPower] != '', [MedicalPower], NULL) AS MedicalPower
			,IIF([Form] != '', [Form], NULL) AS Form
			,IIF([Packing] != '', [Packing], NULL) AS Packing
			,IIF([WayOfUse] != '', [WayOfUse], NULL) AS WayOfUse
			,IIF([Supplement] != '', [Supplement], NULL) AS Supplement
			,IIF([Cover] != '', [Cover], NULL) AS Cover
			,IIF([RegistrationHolder] != '', [RegistrationHolder], NULL) AS RegistrationHolder
			,IIF([HolderCountry] != '', [HolderCountry], NULL) AS HolderCountry
			,IIF([RegistrationState] != '', [RegistrationState], NULL) AS RegistrationState
			,IIF([RegistrationValidTo_DDMMYY] != '', [RegistrationValidTo_DDMMYY], NULL) AS RegistrationValidTo_DDMMYY
			,IIF([UnlimitedRegistration] != '', [UnlimitedRegistration], NULL) AS UnlimitedRegistration
			,IIF([IndicationGroup] != '', [IndicationGroup], NULL) AS IndicationGroup
			,IIF([ATC] != '', [ATC], NULL) AS ATC
			,IIF([ATC_Name] != '', [ATC_Name], NULL) AS ATC_Name
			,IIF([RegistrationNumber] != '', [RegistrationNumber], NULL) AS RegistrationNumber
			,IIF([RegistrationProcedure] != '', [RegistrationProcedure], NULL) AS RegistrationProcedure
			,IIF([WHO_Index] != '', [WHO_Index], NULL) AS WHO_Index
			,IIF([MedicalSubstances] != '', [MedicalSubstances], NULL) AS MedicalSubstances
			,IIF([Dispensing] != '', [Dispensing], NULL) AS Dispensing
			,IIF([Doping] != '', [Doping], NULL) AS Doping
			,IIF([Expiration] != '', [Expiration], NULL) AS Expiration
			,IIF([Expoiration_Type] != '', [Expoiration_Type], NULL) AS Expoiration_Type
			,IIF([RegisteredName] != '', [RegisteredName], NULL) AS RegisteredName
			,[Problem] as Problem
			,IIF(SMD.[DocumentName] != '', SMD.[DocumentName], NULL) AS DocumentName
			,IIF(SMD.[Indications] != '', SMD.[Indications], NULL) AS Indications 
			,IIF(SMD.[Contraindications] != '', SMD.[Contraindications], NULL) AS Contraindications
			,IIF(SMD.[SideEffects] != '', SMD.[SideEffects], NULL) AS SideEffects
			,IIF(SMD.[Validity] != '', SMD.[Validity], NULL) AS Applicability
			,IIF(SMD.[Warnings] != '', SMD.[Warnings], NULL) AS Warnings
			,IIF(SMD.[Interactions] != '', SMD.[Interactions], NULL) AS Interactions
			,IIF(SMD.[Dosage] != '', SMD.[Dosage], NULL) AS Dosage
			,IIF(SMD.[Compositions] != '', SMD.[Compositions], NULL) AS Compositions
			,IIF(SMD.[Substances] != '', SMD.[Substances], NULL) AS Substances
			,IIF(SMD.[Overdose] != '', SMD.[Overdose], NULL) AS Overdose
			,IIF(SPC.[FileType] != '', SPC.[FileType], NULL) AS FileType
			,IIF(SPC.[FileContent] != '', SPC.[FileContent], NULL) AS FileContent
			,IIF(SPC.[Size] != '', SPC.[Size], NULL) AS Size
			,IIF(SPC.[CreatedOn] != '', SPC.[CreatedOn], NULL) AS CreatedOn
		FROM [dbo].[MedicinePills] MP
		LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
		LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
		INNER JOIN CONTAINSTABLE([dbo].[MedicinePills], [Name], @condition) AS S ON S.[Key] = MP.[Id]
		--INNER JOIN FREETEXTTABLE([dbo].[MedicinePills], [Name], @searchText, 1029) AS S ON S.[Key] = MP.Id
		LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
		--WHERE MP.[Name] LIKE '%' + @searchText + '%'
		ORDER BY S.[RANK] DESC, MP.[Name]
	END
	ELSE
	BEGIN
		SELECT TOP (@topN) MP.[Id]
			,[SUKL_Code]
			,[Name] AS MedicineName
			,IIF([MedicalPower] != '', [MedicalPower], NULL) AS MedicalPower
			,IIF([Form] != '', [Form], NULL) AS Form
			,IIF([Packing] != '', [Packing], NULL) AS Packing
			,IIF([WayOfUse] != '', [WayOfUse], NULL) AS WayOfUse
			,IIF([Supplement] != '', [Supplement], NULL) AS Supplement
			,IIF([Cover] != '', [Cover], NULL) AS Cover
			,IIF([RegistrationHolder] != '', [RegistrationHolder], NULL) AS RegistrationHolder
			,IIF([HolderCountry] != '', [HolderCountry], NULL) AS HolderCountry
			,IIF([RegistrationState] != '', [RegistrationState], NULL) AS RegistrationState
			,IIF([RegistrationValidTo_DDMMYY] != '', [RegistrationValidTo_DDMMYY], NULL) AS RegistrationValidTo_DDMMYY
			,IIF([UnlimitedRegistration] != '', [UnlimitedRegistration], NULL) AS UnlimitedRegistration
			,IIF([IndicationGroup] != '', [IndicationGroup], NULL) AS IndicationGroup
			,IIF([ATC] != '', [ATC], NULL) AS ATC
			,IIF([ATC_Name] != '', [ATC_Name], NULL) AS ATC_Name
			,IIF([RegistrationNumber] != '', [RegistrationNumber], NULL) AS RegistrationNumber
			,IIF([RegistrationProcedure] != '', [RegistrationProcedure], NULL) AS RegistrationProcedure
			,IIF([WHO_Index] != '', [WHO_Index], NULL) AS WHO_Index
			,IIF([MedicalSubstances] != '', [MedicalSubstances], NULL) AS MedicalSubstances
			,IIF([Dispensing] != '', [Dispensing], NULL) AS Dispensing
			,IIF([Doping] != '', [Doping], NULL) AS Doping
			,IIF([Expiration] != '', [Expiration], NULL) AS Expiration
			,IIF([Expoiration_Type] != '', [Expoiration_Type], NULL) AS Expoiration_Type
			,IIF([RegisteredName] != '', [RegisteredName], NULL) AS RegisteredName
			,[Problem] = CASE
				WHEN MP.[Id] IN (
					SELECT MP.[Id]
					FROM [dbo].[MedicinePills] MP
					LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
					LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
					LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
					WHERE CONTAINS(([Contraindications], [Substances]), @healthConditions)
				) THEN 'X'
				ELSE NULL 
			END
			,IIF(SMD.[DocumentName] != '', SMD.[DocumentName], NULL) AS DocumentName
			,IIF(SMD.[Indications] != '', SMD.[Indications], NULL) AS Indications 
			,IIF(SMD.[Contraindications] != '', SMD.[Contraindications], NULL) AS Contraindications
			,IIF(SMD.[SideEffects] != '', SMD.[SideEffects], NULL) AS SideEffects
			,IIF(SMD.[Validity] != '', SMD.[Validity], NULL) AS Applicability
			,IIF(SMD.[Warnings] != '', SMD.[Warnings], NULL) AS Warnings
			,IIF(SMD.[Interactions] != '', SMD.[Interactions], NULL) AS Interactions
			,IIF(SMD.[Dosage] != '', SMD.[Dosage], NULL) AS Dosage
			,IIF(SMD.[Compositions] != '', SMD.[Compositions], NULL) AS Compositions
			,IIF(SMD.[Substances] != '', SMD.[Substances], NULL) AS Substances
			,IIF(SMD.[Overdose] != '', SMD.[Overdose], NULL) AS Overdose
			,IIF(SPC.[FileType] != '', SPC.[FileType], NULL) AS FileType
			,IIF(SPC.[FileContent] != '', SPC.[FileContent], NULL) AS FileContent
			,IIF(SPC.[Size] != '', SPC.[Size], NULL) AS Size
			,IIF(SPC.[CreatedOn] != '', SPC.[CreatedOn], NULL) AS CreatedOn
		FROM [dbo].[MedicinePills] MP
		LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
		LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
		INNER JOIN CONTAINSTABLE([dbo].[MedicinePills], [Name], @condition) AS S ON S.[Key] = MP.[Id]
		--INNER JOIN FREETEXTTABLE([dbo].[MedicinePills], [Name], @searchText, 1029) AS S ON S.[Key] = MP.Id
		LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
		--WHERE MP.[Name] LIKE '%' + @searchText + '%'
		ORDER BY S.[RANK] DESC, MP.[Name]
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetMedicinePillsBySideEffects]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetMedicinePillsBySideEffects] 
	@searchText NVARCHAR(300) = NULL,
	@topN INT,
	@healthConditions NVARCHAR(700) = NULL
AS
BEGIN
	DECLARE @condition NVARCHAR(400) = CONCAT('FORMSOF(FREETEXT,"',@searchText,'" )')

	
	IF @healthConditions IS NULL
	BEGIN
		SELECT TOP (@topN) MP.[Id]
			,[SUKL_Code]
			,[Name] AS MedicineName
			,IIF([MedicalPower] != '', [MedicalPower], NULL) AS MedicalPower
			,IIF([Form] != '', [Form], NULL) AS Form
			,IIF([Packing] != '', [Packing], NULL) AS Packing
			,IIF([WayOfUse] != '', [WayOfUse], NULL) AS WayOfUse
			,IIF([Supplement] != '', [Supplement], NULL) AS Supplement
			,IIF([Cover] != '', [Cover], NULL) AS Cover
			,IIF([RegistrationHolder] != '', [RegistrationHolder], NULL) AS RegistrationHolder
			,IIF([HolderCountry] != '', [HolderCountry], NULL) AS HolderCountry
			,IIF([RegistrationState] != '', [RegistrationState], NULL) AS RegistrationState
			,IIF([RegistrationValidTo_DDMMYY] != '', [RegistrationValidTo_DDMMYY], NULL) AS RegistrationValidTo_DDMMYY
			,IIF([UnlimitedRegistration] != '', [UnlimitedRegistration], NULL) AS UnlimitedRegistration
			,IIF([IndicationGroup] != '', [IndicationGroup], NULL) AS IndicationGroup
			,IIF([ATC] != '', [ATC], NULL) AS ATC
			,IIF([ATC_Name] != '', [ATC_Name], NULL) AS ATC_Name
			,IIF([RegistrationNumber] != '', [RegistrationNumber], NULL) AS RegistrationNumber
			,IIF([RegistrationProcedure] != '', [RegistrationProcedure], NULL) AS RegistrationProcedure
			,IIF([WHO_Index] != '', [WHO_Index], NULL) AS WHO_Index
			,IIF([MedicalSubstances] != '', [MedicalSubstances], NULL) AS MedicalSubstances
			,IIF([Dispensing] != '', [Dispensing], NULL) AS Dispensing
			,IIF([Doping] != '', [Doping], NULL) AS Doping
			,IIF([Expiration] != '', [Expiration], NULL) AS Expiration
			,IIF([Expoiration_Type] != '', [Expoiration_Type], NULL) AS Expoiration_Type
			,IIF([RegisteredName] != '', [RegisteredName], NULL) AS RegisteredName
			,[Problem] as Problem
			,IIF(SMD.[DocumentName] != '', SMD.[DocumentName], NULL) AS DocumentName
			,IIF(SMD.[Indications] != '', SMD.[Indications], NULL) AS Indications 
			,IIF(SMD.[Contraindications] != '', SMD.[Contraindications], NULL) AS Contraindications
			,IIF(SMD.[SideEffects] != '', SMD.[SideEffects], NULL) AS SideEffects
			,IIF(SMD.[Validity] != '', SMD.[Validity], NULL) AS Applicability
			,IIF(SMD.[Warnings] != '', SMD.[Warnings], NULL) AS Warnings
			,IIF(SMD.[Interactions] != '', SMD.[Interactions], NULL) AS Interactions
			,IIF(SMD.[Dosage] != '', SMD.[Dosage], NULL) AS Dosage
			,IIF(SMD.[Compositions] != '', SMD.[Compositions], NULL) AS Compositions
			,IIF(SMD.[Substances] != '', SMD.[Substances], NULL) AS Substances
			,IIF(SMD.[Overdose] != '', SMD.[Overdose], NULL) AS Overdose
			,IIF(SPC.[FileType] != '', SPC.[FileType], NULL) AS FileType
			,IIF(SPC.[FileContent] != '', SPC.[FileContent], NULL) AS FileContent
			,IIF(SPC.[Size] != '', SPC.[Size], NULL) AS Size
			,IIF(SPC.[CreatedOn] != '', SPC.[CreatedOn], NULL) AS CreatedOn
		FROM [dbo].[MedicinePills] MP
		LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
		LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
		INNER JOIN CONTAINSTABLE([dbo].[StructuredMedicineDocuments], [SideEffects], @condition) AS S ON S.[Key] = SMD.[Id]
		--INNER JOIN FREETEXTTABLE([dbo].[StructuredMedicineDocuments], [SideEffects], @searchText, 1029) AS S ON S.[Key] = SMD.Id
		LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
		ORDER BY S.[RANK] DESC, [Name]
	END
	ELSE
	BEGIN
		SELECT TOP (@topN) MP.[Id]
		,[SUKL_Code]
		,[Name] AS MedicineName
		,IIF([MedicalPower] != '', [MedicalPower], NULL) AS MedicalPower
		,IIF([Form] != '', [Form], NULL) AS Form
		,IIF([Packing] != '', [Packing], NULL) AS Packing
		,IIF([WayOfUse] != '', [WayOfUse], NULL) AS WayOfUse
		,IIF([Supplement] != '', [Supplement], NULL) AS Supplement
		,IIF([Cover] != '', [Cover], NULL) AS Cover
		,IIF([RegistrationHolder] != '', [RegistrationHolder], NULL) AS RegistrationHolder
		,IIF([HolderCountry] != '', [HolderCountry], NULL) AS HolderCountry
		,IIF([RegistrationState] != '', [RegistrationState], NULL) AS RegistrationState
		,IIF([RegistrationValidTo_DDMMYY] != '', [RegistrationValidTo_DDMMYY], NULL) AS RegistrationValidTo_DDMMYY
		,IIF([UnlimitedRegistration] != '', [UnlimitedRegistration], NULL) AS UnlimitedRegistration
		,IIF([IndicationGroup] != '', [IndicationGroup], NULL) AS IndicationGroup
		,IIF([ATC] != '', [ATC], NULL) AS ATC
		,IIF([ATC_Name] != '', [ATC_Name], NULL) AS ATC_Name
		,IIF([RegistrationNumber] != '', [RegistrationNumber], NULL) AS RegistrationNumber
		,IIF([RegistrationProcedure] != '', [RegistrationProcedure], NULL) AS RegistrationProcedure
		,IIF([WHO_Index] != '', [WHO_Index], NULL) AS WHO_Index
		,IIF([MedicalSubstances] != '', [MedicalSubstances], NULL) AS MedicalSubstances
		,IIF([Dispensing] != '', [Dispensing], NULL) AS Dispensing
		,IIF([Doping] != '', [Doping], NULL) AS Doping
		,IIF([Expiration] != '', [Expiration], NULL) AS Expiration
		,IIF([Expoiration_Type] != '', [Expoiration_Type], NULL) AS Expoiration_Type
		,IIF([RegisteredName] != '', [RegisteredName], NULL) AS RegisteredName
		,[Problem] = CASE
				WHEN MP.[Id] IN (
					SELECT MP.[Id]
					FROM [dbo].[MedicinePills] MP
					LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
					LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
					LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
					WHERE CONTAINS(([Contraindications], [Substances]), @healthConditions)
				) THEN 'X'
				ELSE NULL 
			END 
		,IIF(SMD.[DocumentName] != '', SMD.[DocumentName], NULL) AS DocumentName
		,IIF(SMD.[Indications] != '', SMD.[Indications], NULL) AS Indications 
		,IIF(SMD.[Contraindications] != '', SMD.[Contraindications], NULL) AS Contraindications
		,IIF(SMD.[SideEffects] != '', SMD.[SideEffects], NULL) AS SideEffects
		,IIF(SMD.[Validity] != '', SMD.[Validity], NULL) AS Applicability
		,IIF(SMD.[Warnings] != '', SMD.[Warnings], NULL) AS Warnings
		,IIF(SMD.[Interactions] != '', SMD.[Interactions], NULL) AS Interactions
		,IIF(SMD.[Dosage] != '', SMD.[Dosage], NULL) AS Dosage
		,IIF(SMD.[Compositions] != '', SMD.[Compositions], NULL) AS Compositions
		,IIF(SMD.[Substances] != '', SMD.[Substances], NULL) AS Substances
		,IIF(SMD.[Overdose] != '', SMD.[Overdose], NULL) AS Overdose
		,IIF(SPC.[FileType] != '', SPC.[FileType], NULL) AS FileType
		,IIF(SPC.[FileContent] != '', SPC.[FileContent], NULL) AS FileContent
		,IIF(SPC.[Size] != '', SPC.[Size], NULL) AS Size
		,IIF(SPC.[CreatedOn] != '', SPC.[CreatedOn], NULL) AS CreatedOn
	FROM [dbo].[MedicinePills] MP
	LEFT JOIN [dbo].[MedicineSPC_Mapping] MSM ON MP.[SUKL_Code] = MSM.[MedicineSUKL]
	LEFT JOIN [dbo].[StructuredMedicineDocuments] SMD ON MSM.[DocumentName] = SMD.[DocumentName]
	INNER JOIN CONTAINSTABLE([dbo].[StructuredMedicineDocuments], [SideEffects], @condition) AS S ON S.[Key] = SMD.[Id]
	--INNER JOIN FREETEXTTABLE([dbo].[StructuredMedicineDocuments], [SideEffects], @searchText, 1029) AS S ON S.[Key] = SMD.Id
	LEFT JOIN [dbo].[SPCDocuments] SPC ON MSM.[DocumentName] = SPC.[FileName]
	ORDER BY S.[RANK] DESC, [Name]
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetPharmacyEmail]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetPharmacyEmail] 
	@PharmacyId INT
AS
BEGIN
	SELECT [Email]
	FROM [BP_MedicineDatabase].[dbo].[PharmacyEmail] PE
	WHERE PE.[PharmacyId] = @PharmacyId
	ORDER BY [Id]
END
GO
/****** Object:  StoredProcedure [dbo].[GetPharmacyHours]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetPharmacyHours] 
	@PharmacyId INT
AS
BEGIN
	SELECT [Day]
		,[Time]
	FROM [BP_MedicineDatabase].[dbo].[PharmacyOpeningHours] POH
	WHERE POH.[PharmacyId] = @PharmacyId
	ORDER BY [Id]
END
GO
/****** Object:  StoredProcedure [dbo].[GetPharmacyPhone]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetPharmacyPhone] 
	@PharmacyId INT
AS
BEGIN
	SELECT [Phone]
	FROM [BP_MedicineDatabase].[dbo].[PharmacyPhone] PP
	WHERE PP.[PharmacyId] = @PharmacyId
	ORDER BY [Id]
END
GO
/****** Object:  StoredProcedure [dbo].[GetPharmacyWeb]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetPharmacyWeb] 
	@PharmacyId INT
AS
BEGIN
	SELECT [Web]
	FROM [BP_MedicineDatabase].[dbo].[PharmacyWeb] PW
	WHERE PW.[PharmacyId] = @PharmacyId
	ORDER BY [Id]
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateMedicinePills]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateMedicinePills] 
	@Pills [dbo].[Pills] READONLY
AS
BEGIN

	IF EXISTS (SELECT 1 FROM @Pills)
	BEGIN
		INSERT INTO [dbo].[MedicinePills] (
			SUKL_Code,
			MandatoryReport,
			Name,
			MedicalPower,
			Form,
			Packing,
			WayOfUse,
			Supplement,
			Cover,
			RegistrationHolder,
			HolderCountry,
			ActualHolder,
			ActualHolderCountry,
			RegistrationState,
			RegistrationValidTo_DDMMYY,
			UnlimitedRegistration,
			OnMarketTo_DDMMYY,
			IndicationGroup,
			ATC,
			ATC_Name,
			RegistrationNumber,
			ParallelImport_Number,
			ParallelImport_Importer,
			ParallelImport_Country,
			RegistrationProcedure,
			DefinedDailyDose_MedicineAmount,
			DefinedDailyDose_Union,
			DefinedDailyDose_AmountInPackage,
			WHO_Index,
			MedicalSubstances,
			Dispensing,
			Addiction,
			Doping,
			NarVla,
			SuppliedPast_HalfYear,
			Ean,
			Braille,
			Expiration,
			Expoiration_Type,
			RegisteredName,
			MRP_Number,
			LegalRegistrationBase,
			ProtectiveElement
		)
		SELECT SUKL_Code,
			MandatoryReport,
			Name,
			MedicalPower,
			Form,
			Packing,
			WayOfUse,
			Supplement,
			Cover,
			RegistrationHolder,
			HolderCountry,
			ActualHolder,
			ActualHolderCountry,
			RegistrationState,
			RegistrationValidTo_DDMMYY,
			UnlimitedRegistration,
			OnMarketTo_DDMMYY,
			IndicationGroup,
			ATC,
			ATC_Name,
			RegistrationNumber,
			ParallelImport_Number,
			ParallelImport_Importer,
			ParallelImport_Country,
			RegistrationProcedure,
			DefinedDailyDose_MedicineAmount,
			DefinedDailyDose_Union,
			DefinedDailyDose_AmountInPackage,
			WHO_Index,
			MedicalSubstances,
			Dispensing,
			Addiction,
			Doping,
			NarVla,
			SuppliedPast_HalfYear,
			Ean,
			Braille,
			Expiration,
			Expoiration_Type,
			RegisteredName,
			MRP_Number,
			LegalRegistrationBase,
			ProtectiveElement
		FROM @Pills
	END

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateMedicineSPC_Mapping]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateMedicineSPC_Mapping] 
    --@FileName nvarchar(max) = NULL,
    --@MedicineSUKL nvarchar(7) = NULL
	@Mapping [dbo].[SPCMapping] READONLY
AS
BEGIN
	--DECLARE @MedicineId INT = (SELECT [Id] FROM [dbo].[MedicinePills] WHERE [SUKL_Code] = @MedicineSUKL);
	--DECLARE @DocumentId INT = (SELECT [Id] FROM [dbo].[SPCDocuments] WHERE [FileName] = @FileName);

	--INSERT INTO [dbo].[MedicineSPC_Mapping] ([MedicineId], [DocumentId])
	--VALUES (@MedicineId, @DocumentId);

	IF EXISTS (SELECT 1 FROM @Mapping)
	BEGIN
		INSERT INTO [dbo].[MedicineSPC_Mapping] (MedicineSUKL, DocumentName)
		SELECT MedicineSUKL, DocumentName FROM @Mapping
	END
END
GO
/****** Object:  StoredProcedure [dbo].[UpdatePharmacies]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdatePharmacies]
	@Name NVARCHAR(255),
	@WorkPlaceCode NVARCHAR(100),
	@PharmacyCode NVARCHAR(100),
	@Icz NVARCHAR(50) = NULL,
	@Ico NVARCHAR(40) = NULL,
	@PharmacyType NVARCHAR(100) = NULL,
	@Latitude NVARCHAR(15),
	@Longitude NVARCHAR(15),
	@HasEmergency BIT = 0,
	@ExtendedWorkTime BIT = 0,
	@City NVARCHAR(255) = NULL,
	@Street NVARCHAR(255) = NULL,
	@OrientationNumber NVARCHAR(25) = NULL,
	@DescriptiveNumber NVARCHAR(25) = NULL,
	@Psc NVARCHAR(10) = NULL,
	@PersonName NVARCHAR(255) = NULL,
	@PersonSurname NVARCHAR(255) = NULL,
	@TitleBefore NVARCHAR(25) = NULL,
	@TitleAfter NVARCHAR(25) = NULL,
	@Phones [dbo].[EmailPhoneTable] READONLY,
	@Emails [dbo].[EmailPhoneTable] READONLY,
	@Webs [dbo].[WebTable] READONLY,
	@Hours [dbo].[HoursTable] READONLY
	--@NewId INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [dbo].[Pharmacy] (
		[Name]
		,[WorkPlaceCode]
		,[PharmacyCode]
		,[Icz]
		,[Ico]
		,[PharmacyType]
		,[Latitude]
		,[Longitude]
		,[HasEmergency]
		,[ExtendedWorkTime]
	)VALUES(
		@Name,
		@WorkPlaceCode,
		@PharmacyCode,
		@Icz,
		@Ico,
		@PharmacyType,
		@Latitude,
		@Longitude,
		@HasEmergency,
		@ExtendedWorkTime
	)

	DECLARE @PharmacyId INT
	--SET @NewId = (SELECT SCOPE_IDENTITY())
	SET @PharmacyId = (SELECT SCOPE_IDENTITY())


	INSERT INTO [dbo].[PharmacyAddress] (
		[PharmacyId]
		,[City]
		,[Street]
		,[OrientationNumber]
		,[DescriptiveNumber]
		,[Psc]
	)VALUES(
		@PharmacyId,
		@City,
		@Street,
		@OrientationNumber,
		@DescriptiveNumber,
		@Psc
	)

	INSERT INTO [dbo].[Pharmacist] (
		[PharmacyId]
		,[Name]
		,[Surname]
		,[TitleBefore]
		,[TitleAfter]
	)VALUES(
		@PharmacyId,
		@PersonName,
		@PersonSurname,
		@TitleBefore,
		@TitleAfter
	)

	IF EXISTS (SELECT 1 FROM @Phones)
	BEGIN
		INSERT INTO [dbo].[PharmacyPhone] (Phone, PharmacyId)
		SELECT Value, @PharmacyId
		FROM @Phones
	END
	
	IF EXISTS (SELECT 1 FROM @Emails)
	BEGIN
		INSERT INTO [dbo].[PharmacyEmail] (Email, PharmacyId)
		SELECT Value, @PharmacyId
		FROM @Emails
	END

	IF EXISTS (SELECT 1 FROM @Webs)
	BEGIN
		INSERT INTO [dbo].[PharmacyWeb] (Web, PharmacyId)
		SELECT Value, @PharmacyId
		FROM @Webs
	END

	IF EXISTS (SELECT 1 FROM @Hours)
	BEGIN
		INSERT INTO [dbo].[PharmacyOpeningHours] (PharmacyId, Day, Time)
		SELECT @PharmacyId, Day, Time 
		FROM @Hours
	END
END
GO
/****** Object:  StoredProcedure [dbo].[UpdatePharmacist]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdatePharmacist]
	@PharmacyId INT,
	@Name NVARCHAR(255),
	@Surname NVARCHAR(255),
	@TitleBefore NVARCHAR(25) = NULL,
	@TitleAfter NVARCHAR(25) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [dbo].[Pharmacist] (
		[PharmacyId]
		,[Name]
		,[Surname]
		,[TitleBefore]
		,[TitleAfter]
	)VALUES(
		@PharmacyId,
		@Name,
		@Surname,
		@TitleBefore,
		@TitleAfter
	)
END
GO
/****** Object:  StoredProcedure [dbo].[UpdatePharmacyAddress]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdatePharmacyAddress]
	@PharmacyId INT,
	@City NVARCHAR(255),
	@Street NVARCHAR(255),
	@OrientationNumber NVARCHAR(25) = NULL,
	@DescriptiveNumber NVARCHAR(25) = NULL,
	@Psc NVARCHAR(10) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [dbo].[PharmacyAddress] (
		[PharmacyId]
		,[City]
		,[Street]
		,[OrientationNumber]
		,[DescriptiveNumber]
		,[Psc]
	)VALUES(
		@PharmacyId,
		@City,
		@Street,
		@OrientationNumber,
		@DescriptiveNumber,
		@Psc
	)
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateSPCDocuments]    Script Date: 17. 7. 2023 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateSPCDocuments] 
    @FileName nvarchar(max) = NULL,
    @FileType nvarchar(50) = NULL,
	@FileContent varbinary(MAX) = NULL,
    @Size nvarchar(50) = NULL,
	@CreatedOn DATETIME = NULL
AS
BEGIN
	
	INSERT INTO [dbo].[SPCDocuments]
           ([FileName]
           ,[FileType]
           ,[FileContent]
           ,[Size]
           ,[CreatedOn])
     VALUES
           (@FileName, @FileType, @FileContent, @Size, @CreatedOn)


END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateStructuredMedicineDocuments] 
	@StructuredData [dbo].[StructuredDocs] READONLY
AS
BEGIN
	
	IF EXISTS(SELECT 1 FROM @StructuredData)
	BEGIN
		INSERT INTO [dbo].[StructuredMedicineDocuments] (
		   [DocumentName]
           ,[Indications]
           ,[Contraindications]
           ,[SideEffects]
           ,[Validity]
           ,[Warnings]
           ,[Interactions]
           ,[Dosage]
           ,[Compositions]
           ,[Substances]
           ,[Overdose]
		)
     SELECT [DocumentName]
           ,[Indications]
           ,[Contraindications]
           ,[SideEffects]
           ,[Validity]
           ,[Warnings]
           ,[Interactions]
           ,[Dosage]
           ,[Compositions]
           ,[Substances]
           ,[Overdose]
	FROM @StructuredData
	END

END
GO