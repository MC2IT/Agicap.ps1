namespace Mc2it.Agicap.Suppliers

open System.Management.Automation

/// Creates a new supplier.
[<Cmdlet(VerbsCommon.New, "Supplier"); OutputType(typeof<Supplier>)>]
type NewSupplierCommand() =
  inherit Cmdlet()

  /// The identifier of the supplier in the ERP software.
  [<Parameter(Position = 1)>]
  member val ErpId = "" with get, set

  /// The display name.
  [<Parameter(Position = 2)>]
  member val Name = "" with get, set

  /// The contacts of this supplier.
  [<Parameter; ValidateNotNull>]
  member val Contacts: Contact array = [||] with get, set

  /// The ISO 639-1 code of the supplier preferred language.
  [<Parameter>]
  member val Language = "" with get, set

  /// The legal address of this supplier.
  [<Parameter>]
  member val LegalAddress: LegalAddress | null = null with get, set

  /// The legal registration identifier (e.g. LEI, SIRET, company number...).
  [<Parameter>]
  member val LegalCompanyId = "" with get, set

  /// The legal name of this supplier, when it differs from the display name.
  [<Parameter>]
  member val LegalName = "" with get, set

  /// The primary contact of this supplier.
  [<Parameter>]
  member val PrimaryContact: Contact | null = null with get, set

  /// The lifecycle status of this supplier, as pushed by the ERP software.
  [<Parameter>]
  member val Status = "" with get, set

  /// The tags associated with this supplier.
  [<Parameter; ValidateNotNull>]
  member val Tags: string array = [||] with get, set

  /// The third-party accounting code of this supplier.
  [<Parameter>]
  member val ThirdPartyCode = "" with get, set

  /// The VAT code of this supplier.
  [<Parameter>]
  member val VatCode = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (Supplier (
    Contacts = (if this.Contacts.Length > 0 then withNull this.Contacts else null),
    ErpId = (if this.ErpId.Length > 0 then this.ErpId else null),
    Language = (if this.Language.Length > 0 then this.Language else null),
    LegalAddress = this.LegalAddress,
    LegalCompanyId = (if this.LegalCompanyId.Length > 0 then this.LegalCompanyId else null),
    LegalName = (if this.LegalName.Length > 0 then this.LegalName else null),
    Name = (if this.Name.Length > 0 then this.Name else null),
    PrimaryContact = this.PrimaryContact,
    Status = (if this.Status.Length > 0 then this.Status else null),
    Tags = (if this.Tags.Length > 0 then withNull this.Tags else null),
    ThirdPartyCode = (if this.ThirdPartyCode.Length > 0 then this.ThirdPartyCode else null),
    VatCode = (if this.VatCode.Length > 0 then this.VatCode else null)
  ))
