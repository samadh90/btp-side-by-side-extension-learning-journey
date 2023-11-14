using {riskmanagement as rm} from '../db/schema';

/*@path: 'service/risk'
service RiskService {
    entity Risks            as projection on rm.Risks;
    annotate Risks with @odata.draft.enabled;
    entity Mitigations      as projection on rm.Mitigations;
    annotate Mitigations with @odata.draft.enabled;

    // BusinessPartner will be used later
    @readonly
    entity BusinessPartners as projection on rm.BusinessPartners;

}*/

@path: 'service/risk'
service RiskService@(requires: 'authenticated-user') {
    entity Risks @(restrict: [
        {
            grant: 'READ',
            to: 'RiskViews'
        },
        {
            grand: [
                'READ',
                'CREATE',
                'UPDATE',
                'UPSERT',
                'DELETE'
            ], // Allowing CDS events by explicitly mentioning them
            to: 'RiskManager'
        }
    ])       as projection on rm.Risks;

    annotate Risks with @odata.draft.enabled;

    entity Mitigations @(restrict: [
        {
            grant: 'READ',
            to: 'RiskViewer'
        },
        {
            grant: '*', // Allow everything using wilkdcard
            to: 'RiskManager'
        }
    ]) as projection on rm.Mitigations;

    annotate Mitigations with @odata.draft.enabled;

    // BusinessPartner will be used later
    @readonly entity BusinessPartners as projection on rm.BusinessPartners;
}
