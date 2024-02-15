UPDATE cstb_contract
                SET counterparty = '004127258'
                WHERE counterparty = '003979641';
UPDATE sitb_instruction
                SET counterparty = '004127258'
                WHERE counterparty = '003979641';
UPDATE cstb_contract_event_advice
                SET party_id = '004127258';
                WHERE party_id = '003979641';
UPDATE cftb_charge_appln
                SET counterparty = '004127258',
                    charge_party_cif_id = '004127258'
                WHERE counterparty = '003979641';
UPDATE cftb_charge_liqd_master
                SET counterparty = '004127258'
                where counterparty = '003979641';
UPDATE mitb_class_mapping
                SET customer = '004127258'
                WHERE customer = '003979641';
