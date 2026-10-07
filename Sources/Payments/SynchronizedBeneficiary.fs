namespace Mc2it.Agicap.Payments

open System.Management.Automation

/// Creates a new beneficiary for a synchronization request.
[<Cmdlet(VerbsCommon.New, "SynchronizedBeneficiary"); OutputType(typeof<SynchronizedBeneficiary>)>]
type NewSynchronizedBeneficiary() =
  inherit Cmdlet()

  /// The identifier of the beneficiary in the ERP software.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val ErpId = "" with get, set

  /// The beneficiary to synchronize.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Beneficiary: Beneficiary | null = null with get, set

  /// The ERP identifiers of the suppliers to associate with this beneficiary.
  [<Parameter; ValidateNotNull>]
  member val SupplierErpId: string array = [||] with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (SynchronizedBeneficiary (
    this.ErpId,
    nonNull this.Beneficiary,
    SupplierErpIds = (if this.SupplierErpId.Length > 0 then withNull this.SupplierErpId else null)
  ))
