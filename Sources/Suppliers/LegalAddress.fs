namespace Mc2it.Agicap.Suppliers

open System.Management.Automation

/// Creates a new legal address.
[<Cmdlet(VerbsCommon.New, "LegalAddress"); OutputType(typeof<LegalAddress>)>]
type NewLegalAddress() =
  inherit Cmdlet()

  /// The address number.
  [<Parameter>]
  member val Number = "" with get, set

  /// The street name.
  [<Parameter>]
  member val StreetName = "" with get, set

  /// The name of the city.
  [<Parameter>]
  member val City = "" with get, set

  /// The postal code of the supplier location.
  [<Parameter>]
  member val PostalCode = "" with get, set

  /// The state in which the supplier is located.
  [<Parameter>]
  member val State = "" with get, set

  /// The ISO 3166 alpha-2 code of the country in which the supplier is located.
  [<Parameter(Mandatory = true); AllowEmptyString>]
  member val Country = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (LegalAddress (
    City = (if this.City.Length > 0 then this.City else null),
    Country = this.Country,
    Number = (if this.Number.Length > 0 then this.Number else null),
    PostalCode = (if this.PostalCode.Length > 0 then this.PostalCode else null),
    State = (if this.State.Length > 0 then this.State else null),
    StreetName = (if this.StreetName.Length > 0 then this.StreetName else null)
  ))
