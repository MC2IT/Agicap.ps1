namespace Mc2it.Agicap

open System
open System.Management.Automation

/// Creates a new journal entry that was not imported in the client accounting system.
[<Cmdlet(VerbsCommon.New, "NotImportedEntry"); OutputType(typeof<NotImportedEntry>)>]
type NewNotImportedEntry() =
  inherit Cmdlet()

  /// A unique identifier from Agicap.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val EntryAgicapUniqueId = Guid.Empty with get, set

  /// The errors preventing the journal entry from being imported.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Errors: NotImportedEntryError array = [||] with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (NotImportedEntry (
    EntryAgicapUniqueId = this.EntryAgicapUniqueId,
    Errors = this.Errors
  ))

/// Creates a new import error for a journal entry.
[<Cmdlet(VerbsCommon.New, "NotImportedEntryError"); OutputType(typeof<NotImportedEntryError>)>]
type NewNotImportedEntryError() =
  inherit Cmdlet()

  /// The error type.
  [<Parameter(Mandatory = true, Position = 1)>]
  [<ValidateSet("OTHER", "UNKNOWN_ANALYTICAL_CODE", "UNKNOWN_CURRENCY", "UNKNOWN_EXPENSE_ACCOUNT", "UNKNOWN_THIRD_PARTY", "UNKNOWN_VAT_ACCOUNT")>]
  member val ErrorType = "" with get, set

  /// A message describing the error.
  [<Parameter(Position = 2)>]
  member val ErrorMessage = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (NotImportedEntryError (
    ErrorMessage = (if this.ErrorMessage.Length > 0 then this.ErrorMessage else null),
    ErrorType = this.ErrorType
  ))
