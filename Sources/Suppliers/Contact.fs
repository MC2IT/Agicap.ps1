namespace Mc2it.Agicap.Suppliers

open System.Management.Automation

/// Creates a new contact.
[<Cmdlet(VerbsCommon.New, "Contact"); OutputType(typeof<Contact>)>]
type NewContact() =
  inherit Cmdlet()

  /// The street name.
  [<Parameter(Position = 1)>]
  member val Name = "" with get, set

  /// The address number.
  [<Parameter>]
  member val Email = "" with get, set

  /// The postal code of the supplier location.
  [<Parameter>]
  member val Phone = "" with get, set

  /// The state in which the supplier is located.
  [<Parameter>]
  member val Role = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (Contact (
    Email = (if this.Email.Length > 0 then this.Email else null),
    Name = (if this.Name.Length > 0 then this.Name else null),
    Phone = (if this.Phone.Length > 0 then this.Phone else null),
    Role = (if this.Role.Length > 0 then this.Role else null)
  ))
