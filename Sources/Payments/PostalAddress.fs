namespace Mc2it.Agicap.Payments

open System.Management.Automation

/// Creates a new postal address.
[<Cmdlet(VerbsCommon.New, "PostalAddress"); OutputType(typeof<PostalAddress>)>]
type NewPostalAddress() =
  inherit Cmdlet()

  /// The address number.
  [<Parameter>]
  member val Number = "" with get, set

  /// The street name.
  [<Parameter(Mandatory = true); AllowEmptyString>]
  member val StreetName = "" with get, set

  /// The name of the city.
  [<Parameter(Mandatory = true); AllowEmptyString>]
  member val City = "" with get, set

  /// The postal code of the beneficiary location.
  [<Parameter>]
  member val ZipCode = "" with get, set

  /// The state in which the beneficiary is located.
  [<Parameter>]
  member val State = "" with get, set

  /// The ISO 3166 alpha-2 code of the country in which the beneficiary is located.
  [<Parameter(Mandatory = true); AllowEmptyString>]
  member val Country = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (PostalAddress (
    City = this.City,
    Country = this.Country,
    Number = (if this.Number.Length > 0 then this.Number else null),
    State = (if this.State.Length > 0 then this.State else null),
    StreetName = this.StreetName,
    ZipCode = (if this.ZipCode.Length > 0 then this.ZipCode else null)
  ))
