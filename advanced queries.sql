------------
SELECT COUNT(*) FROM gst_test.account_master;
SELECT COUNT(*) FROM gst_demo.account_master;



SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
 WHERE table_catalog = 'gst_test' AND table_name = 'account_master';
 ---------------------------

SELECT *FROM document_header WHERE  fk_document_type='sales_bill'AND series='GSB' AND doc_no IN (1759,1761,1655,1660,1716);

SELECT*FROM customer_master WHERE pk_customer_master_id IN (SELECT party_id FROM document_header WHERE  fk_document_type='sales_bill'AND series='GSB' AND doc_no IN (1759,1761,1655,1660,1716));

SELECT*FROM customer_master WHERE CONCAT(first_name,' ', last_name)IN (SELECT CONCAT(first_name,' ', last_name) FROM customer_master WHERE fk_account_id IS NULL);


-- basic scripts
-- item details
SELECT * FROM `item_details` ORDER BY 1 DESC ; 

-- find item details from document no.
SELECT * FROM `item_details` WHERE `pk_item_details_id` IN (SELECT `fk_item_detail_id` FROM `document_stock_details` WHERE `fk_document_header_id` IN(SELECT `pk_document_header_id` FROM `document_header` WHERE `series`='SIW' and doc_no='1'));

-- find item_Details from document header id
SELECT * FROM `item_details` WHERE `pk_item_details_id` IN (SELECT `fk_item_detail_id` FROM `document_stock_details` WHERE `fk_document_header_id` = '106');

-- find document header details from item category ID
SELECT * FROM document_header  WHERE pk_document_header_id 
IN(SELECT fk_document_header_id FROM document_stock_details WHERE fk_item_detail_id IN (SELECT pk_item_details_id FROM `item_details` WHERE fk_item_category_id=1300));

-- find sales bill document no from urd exchange auto document
SELECT *FROM document_header WHERE pk_document_header_id IN(SELECT auto_doc_source_no FROM document_header WHERE fk_document_type='urd_exchange_voucher'AND series='UEAL' AND doc_no='1');

-- deployment help queries
SELECT * FROM `document_header` ORDER BY 1 DESC;
SELECT * FROM `document_header` WHERE `pk_document_header_id` >'61' ORDER BY 1 DESC; 
SELECT * FROM `item_details`WHERE `pk_item_details_id` >'49' ORDER BY 1 DESC; 
SELECT * FROM `document_stock_details` WHERE ``pk_document_stock_details_id`` >'59' ORDER BY 1 DESC; 

-- -----------------
SELECT * FROM `document_account_details` WHERE `fk_document_header_id` IN(3,4);
SELECT * FROM `document_header` WHERE `pk_document_header_id` IN(3,4);
SELECT * FROM `document_stock_details` WHERE `fk_document_header_id` IN(3,4);

SELECT * FROM `item_details` WHERE `pk_item_details_id` IN 
(SELECT `fk_item_detail_id` FROM `document_stock_details` WHERE `fk_document_header_id` IN(SELECT pk_document_header_id FROM document_header WHERE fk_document_type = 'sales_bill'));

SELECT * FROM `document_stock_details` WHERE `fk_document_header_id` IN (SELECT pk_document_header_id FROM document_header WHERE series = 'RNG')
SELECT * FROM document_header WHERE series = 'RNG';
-- advance queries 

-- CHECK db revision
SELECT value FROM lookup_value WHERE parameter_name='DBRevision';
-- -------------------------
INSERT INTO `document_header` (`pk_document_header_id`, `fk_branch_id`, `document_date`, `document_date_no`, `series`, `doc_no`, `fy_year`, `from_loc_id`, `to_loc_id`, `party_id`, `challan_no`, `challan_date`, `invoice_no`, `invoice_date`, `invoice_amount`, `fk_document_master_id`, `fk_document_type`, `affect_stock`, `auto_doc_source_no`, `fk_sub_karagir_id`, `doc_status`, `machine_name`, `no_of_times_doc_printed`, `party_name`, `party_address`, `party_phone`, `fk_ptr_header`, `fk_ptr_bill_series`, `fk_ptr_bill_no`, `order_no`, `is_tcs_applicable`, `session_id`, `status`, `is_auto_generated`, `is_cancelled`, `operation_type`, `is_deleted`, `narration`, `rate_freeze_pct`, `metal_rate_freeze`, `fk_rate_freeze_login`, `customer_order_pending_amt_grace_period`, `customer_order_bill_after_days`, `stock_tally_type`, `tally_by_item_id`, `tally_by_item_category_id`, `imported_branch_id`, `imported_branch_name`, `imported_document_no`, `imported_document_header_id`, `imported_excel_path`, `order_status`, `sales_return_allowed_days`, `third_party_id`, `is_order_completed`, `do_not_allow_anonymous_name_jama`, `check_individual_karagir_shop_balance`, `inserted_by_name`, `last_upd_by`, `last_upd_when`, `last_upd_by_name`, `inserted_by`, `inserted_when`, `document_purchase_type`, `affects_metal_balances`, `fk_vat_type_master_id`, `fk_excise_type_master_id`, `fk_reorder_level_template_id`, `balance_type`, `apply_majuri`, `document_sub_type`, `rate_cut_for`, `is_forced`, `vastu_jama`, `bank_loan`, `day_end_passing_status`, `day_end_passed_by`, `day_end_passed_datetime`, `day_end_passing_narration`, `source_pk_document_header_id`, `is_migrated`, `source_db_unique_id`, `fk_imported_data_pk_id`, `girvi_interest_percentage`, `interest_calculation_method`, `account_status`, `imported_when`, `duration`, `expected_closure_date`, `gold_smith_commition_percentage`, `processing_fees_percentage`) VALUES ('4', '3', '2017-04-01 00:00:00', '20170401', 'OPN', '1', '1718', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '188', 'opening_balance', NULL, NULL, NULL, 'approved', 'Abc', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2cw5avui53jdd0mutc2loj0c', 'saved', NULL, 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'metal', '1', '2017-03-15 14:54:27', 'metal', '1', '2017-03-15 14:54:27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL); 
-- find duplicate rows from document print mapping
SELECT fk_document_master_id, fk_column_id,COUNT(*)FROM `document_column_mapping` GROUP BY fk_document_master_id, `fk_column_id` HAVING COUNT(*)>1;

-- document print setting mapping
SELECT *FROM document_print_setting WHERE fk_document_master_id IN(SELECT DISTINCT`fk_document_master_id` FROM document_header );WHERE `fk_document_type`='sales_bill');
SELECT *FROM document_print_setting dps RIGHT JOIN document_header dh ON  dps.fk_document_master_id IN(SELECT DISTINCT dh.`fk_document_master_id` FROM document_header );

SELECT*FROM document_print_setting WHERE fk_document_master_id IN(SELECT `pk_document_master_id` FROM document_master WHERE `document_type`IN ('sales_bill','urd_purchase_voucher','urd_exchange_voucher'));
UPDATE document_print_setting SET print_subreport='Yes' WHERE fk_document_master_id IN(SELECT `pk_document_master_id` FROM document_master WHERE `document_type`IN ('sales_bill','urd_purchase_voucher','urd_exchange_voucher'));

-- dad related 
SELECT*FROM document_account_details WHERE `fk_document_header_id`=10252;
SELECT*FROM document_stock_details WHERE `fk_document_header_id`=10252 AND fk_item_detail_id=20492 ;
SELECT*FROM item_Details WHERE barcode_no='MMN4706267';

-- dh id join
SELECT pk_document_header_id,`document_date`,`series`,`doc_no` , `fk_from_loc_id`,`fk_to_loc_id`,fk_current_location,document_stock_details.`status`,item_details.`purity`,`urd_purity`FROM document_Stock_Details 
JOIN document_header ON `fk_document_header_id`=`pk_document_header_id` 
JOIN item_details ON `pk_item_details_id`=`fk_item_detail_id`  ORDER BY 1 DESC; 

-- update dsd to location 
UPDATE document_Stock_Details JOIN document_header 
ON `fk_document_header_id`=`pk_document_header_id` 
SET document_Stock_Details.`fk_to_loc_id`='9' 
WHERE series= 'UEE' AND document_header.is_cancelled='N' 
AND document_Stock_Details.`fk_to_loc_id`='2';

-- document print mapping
SELECT *FROM document_print_setting WHERE fk_document_master_id IN (SELECT `pk_document_master_id` FROM document_master WHERE `document_type`='sales_bill');

UPDATE document_print_setting SET print_file_name='template_1.1_chordiya.rpt' WHERE fk_document_master_id IN (SELECT `pk_document_master_id` FROM document_master WHERE `document_type`='sales_bill');

SELECT *FROM document_print_setting WHERE fk_document_master_id IN (SELECT `pk_document_master_id` FROM document_master WHERE `document_type`='urd_exchange_voucher');
UPDATE document_print_setting SET print_file_name='template_1.1_chordiya.rpt' WHERE fk_document_master_id IN (SELECT `pk_document_master_id` FROM document_master WHERE `document_type`='sales_bill');
---------------------------------------------------------------------

-- document header and document account Details join
SELECT `pk_document_header_id`, `series`, `doc_no` ,`transaction_type`,`fk_account_id`,account_name,`debit_amount`,`credit_amount`,`source_doc_no`,`dad_ptr`,reference_type FROM  document_account_details, document_header, account_master WHERE `fk_document_header_id`=pk_document_header_id AND fk_account_id=pk_account_master_id;

-- itemdetails from document header
SELECT * FROM `item_details` WHERE `pk_item_details_id` IN (SELECT `fk_item_detail_id` FROM `document_stock_details` WHERE `fk_document_header_id` = '70');

-- set print file as per document_type`
UPDATE `document_print_setting` SET `print_file_name` = 'template_1.2.rpt' WHERE fk_document_master_id IN (SELECT pk_document_master_id FROM document_master WHERE `document_type`='sales_bill');

-- select from header from item_details
SELECT * FROM document_header  WHERE pk_document_header_id 
IN(SELECT fk_document_header_id FROM document_stock_details WHERE fk_item_detail_id= 288);

-- advanced queries
-- join between dad, id and dsd with condition from loc and to location is null
SELECT pk_document_header_id,`document_date`,`series`,`doc_no` , `fk_from_loc_id`,`fk_to_loc_id`,document_stock_details.`status`,item_details.`purity`,`urd_purity`FROM document_Stock_Details JOIN document_header ON `fk_document_header_id`=`pk_document_header_id` JOIN item_details ON `pk_item_details_id`=`fk_item_detail_id` WHERE `fk_from_loc_id`IS NULL AND`fk_to_loc_id` IS NULL AND document_header.is_cancelled='N';

SELECT `document_date`,`series`,`doc_no` ,affect_stock, `fk_from_loc_id`,`fk_to_loc_id`,document_stock_details.`status`FROM document_Stock_Details JOIN document_header ON `fk_document_header_id`=`pk_document_header_id` WHERE series= 'GTR' AND doc_no='1'AND document_header.is_cancelled='N'GROUP BY series;


-- 
CALL item_wise_stock_SR("20160901","20161129",4,3609);

-- ACCOUNT WISE DAD
SELECT SUM(debit_amount) FROM DOCUMENT_ACCOUNT_DETAILS  JOIN document_header ON `pk_document_header_id`=`fk_document_header_id` WHERE (document_header.`document_date` BETWEEN '2016-07-01 09:37:08' AND '2016-11-29 15:37:08')AND `fk_account_id`='34' AND is_cancelled='N';

-- BALANCE sheet grp wise dad
SELECT SUM(debit_amount) AS Expenditures, SUM(credit_Amount) AS Incomes ,SUM(debit_amount)- SUM(credit_Amount) AS "profit/gain"  FROM DOCUMENT_ACCOUNT_DETAILS  JOIN document_header ON `pk_document_header_id`=`fk_document_header_id` JOIN account_master ON `pk_account_master_id` = fk_account_id JOIN `balance_sheet_group` ON `fk_balance_sheet_group_id`=`pk_balance_sheet_group_id` WHERE (document_header.`document_date` BETWEEN '2016-07-01 09:37:08' AND '2016-11-29 18:37:08')AND `pk_balance_sheet_group_id`IN(15,16,30,33,8) AND is_cancelled='N';

SELECT * FROM document_stock_details WHERE `fk_document_header_id` IN (SELECT fk_document_header_id FROM document_Stock_Details JOIN document_header ON `fk_document_header_id`=`pk_document_header_id` JOIN item_details ON `pk_item_details_id`=`fk_item_detail_id` WHERE `fk_from_loc_id`IS NULL AND`fk_to_loc_id` IS NULL AND document_header.is_cancelled='N');

SELECT barcode_no,sales_rate,take_rate_from FROM `item_details` WHERE `fk_metal_name` = 'MRP' AND current_status='Available'; 


-- ILCB SCRIPT
SELECT`pk_item_location_closing_balances_id`, `date`,`fk_karagir_id`,`fk_item_master_id`,`fk_item_category_id`,`fk_purity_id`,`opening_weight`,`inward_weight`,`outward_weight`,`closing_weight`,`fk_location_id`,`last_upd_by`,`opening_gross_wt`,`closing_gross_wt` FROM `item_location_closing_balances` WHERE `fk_item_category_id`=8800 AND `fk_location_id`=4 ORDER BY 1 DESC;

-- update item details fk_metal_name with pcg fk_metal_name
UPDATE item_details SET fk_metal_name = 'Silver' WHERE `fk_item_id` IN (SELECT `pk_item_master_id` FROM `item_master` im
JOIN `product_classification_group` pcg 
ON pcg.`pk_product_classification_group_id`= im.`fk_product_classification_group_id` 
WHERE pcg.`fk_metal_name`='Silver') AND fk_metal_name IS NULL;

--
START TRANSACTION ;
SAVEPOINT atul123;
UPDATE item_details SET item_details.`fk_metal_name`= product_classification_group.fk_metal_name  
JOIN  `item_master` 
ON `pk_item_master_id`=`fk_item_id` 
JOIN `product_classification_group` 
ON `pk_product_classification_group_id`= `fk_product_classification_group_id` 
WHERE item_details.`fk_metal_name` IS NULL;
ROLLBACK TO atul123;

-- khushbu query
 SELECT * FROM document_header WHERE pk_document_header_id IN  (SELECT pk_document_header_id FROM item_details id ,document_stock_details dsd,document_header dh
WHERE id.pk_item_details_id=dsd.fk_item_detail_id AND dh.pk_document_header_id=dsd.fk_document_header_id
 AND fk_from_loc_id IS NOT NULL  AND fk_to_loc_id =8  AND is_cancelled="N" AND affect_stock="Y");
 
 SELECT*FROM document_header ORDER BY 1 DESC;
SELECT pk_document_header_id,document_date,document_date_no,series,doc_no,affect_stock,invoice_no FROM document_header ORDER BY 1 DESC;

SELECT*FROM document_stock_details ORDER BY 1 DESC;
SELECT*FROM item_details ORDER BY 1 DESC;
SELECT pk_item_details_id,barcode_no,fk_item_id,fk_item_category_id,gross_wt,fk_metal_name,current_status,fk_current_location FROM item_details ORDER BY 1 DESC;

SELECT*FROM document_account_details where;


SELECT*FROM document_account_details ORDER BY 1 DESC;
SELECT* FROM document_master WHERE series= 'gss'ORDER BY 1 DESC;
UPDATE document_master SET scan_urd_note='N' WHERE series= 'GSS';

SELECT*FROM  document_account_details WHERE fk_account_id IN (SELECT fk_account_master_id FROM `account_classification_transaction_type_mapping` WHERE `fk_account_classification_group_id` = '25' );

SELECT*FROM details_block_master WHERE details_block_type LIKE'%urd%';
SELECT *FROM details_block_master WHERE details_block_type LIKE'%sales%';

SELECT `document_date`,`series`,`doc_no` ,affect_stock, `fk_from_loc_id` "DSD FROM LOC",`fk_to_loc_id`,document_stock_details.`status`,pk_item_details_id,barcode_no,fk_item_id,fk_item_category_id,fk_purity_id,gross_wt,fk_metal_name,current_status,fk_current_location FROM document_Stock_Details JOIN document_header ON `fk_document_header_id`=`pk_document_header_id` JOIN item_details ON `pk_item_details_id`=`fk_item_detail_id` WHERE series= 'UEV' AND document_header.is_cancelled='N';GROUP BY series;

SELECT*FROM item_details WHERE fk_item_category_id=8878

UPDATE `item_master` SET `maintain_stock_in`='WT_PCS' WHERE `maintain_stock_in`='WT'; 
UPDATE `document_master` SET `allow_barcoded_stock_sale_as_loose`='Y' WHERE `document_type`='sales_bill'; 

SELECT* FROM item_master WHERE pk_item_master_id IN(SELECT fk_item_master_id FROM item_category_master WHERE pk_item_category_master_id IN(SELECT fk_item_category_id FROM item_category_making_master_mapping WHERE fk_making_id IN (SELECT pk_making_type_master_id FROM making_type_master WHERE pk_making_type_master_id IN (SELECT DISTINCT fk_making_id FROM item_category_making_master_mapping) AND wastage_lumpsum <> '0.000')));GROUP BY wastage_calculation_as_per;
SELECT* FROM item_master WHERE pk_item_master_id IN(SELECT fk_item_master_id FROM item_category_master WHERE pk_item_category_master_id IN(SELECT fk_item_category_id FROM item_category_making_master_mapping WHERE fk_making_id IN (SELECT pk_making_type_master_id FROM making_type_master WHERE pk_making_type_master_id IN (SELECT DISTINCT fk_making_id FROM item_category_making_master_mapping) AND wastage_per_pcs <> '0.000')));

-- vaishali  queries
-- to update party address in document header 
UPDATE document_header dh
JOIN customer_master cm ON cm.`pk_customer_master_id`=dh.party_id
SET party_address = cm.address
WHERE dh.party_name=CONCAT(IFNULL(cm.last_name,''),' ',IFNULL(cm.first_name,''),' ',IFNULL(cm.middle_name,''))
AND party_address IS NULL;

(optional
UPDATE document_header dh
JOIN customer_master cm ON dh.party_name=CONCAT(IFNULL(cm.last_name,''),' ',IFNULL(cm.first_name,''),' ',IFNULL(cm.middle_name,''))
SET party_address = cm.address;
)

SELECT CONCAT(IFNULL(first_name ,''),' ',IFNULL(middle_name,''),' ',IFNULL(last_name,'')) AS 'customer name',mobile_no1  FROM customer_master WHERE mobile_no1 IS NOT NULL;

-- find duplicate rows
SELECT `fk_employee_master_id`,`fk_branch_id`,`fk_document_master_id`, COUNT(*)  FROM `employee_document_master_mapping` 
GROUP BY `fk_employee_master_id`,`fk_branch_id`,`fk_document_master_id` HAVING COUNT(*)>1;

SELECT `fk_role_master_id`,`fk_branch_id`,`fk_document_master_id`, COUNT(*)  FROM `role_document_master_mapping`
GROUP BY `fk_role_master_id`,`fk_branch_id`,`fk_document_master_id` HAVING COUNT(*)>1;

DELETE FROM `role_document_master_mapping` WHERE `fk_document_master_id` IS NULL;

-- find duplicate rows from ILCB Date filter
SELECT DATE,`fk_item_master_id`,`fk_item_category_id`,`fk_purity_id`, COUNT(*),fk_location_id  FROM `item_location_closing_balances` WHERE DATE = '2017-02-15'
GROUP BY `fk_item_master_id`,`fk_item_category_id`,`fk_purity_id` HAVING COUNT(*)>1;

-- khushbu  document print setting 
--------------------------------------------------
SET @rptFileName="GeneralJamaNave.rpt";
SET @document_type="karagir_metal_nave";

INSERT INTO `document_print_setting` (`pk_document_print_setting_id`, `fk_document_master_id`,
`receipt_title`, `print_file_name`, `number_of_copies`, `print_sequence`, `tax_invoice`,
`print_subreport`, `inserted_by`, `inserted_when`, `inserted_by_name`, `last_upd_by`,
`last_upd_when`, `last_upd_by_name`, `take_address_from_branch_master`)
 
SELECT NULL,`fk_document_master_id`,`receipt_title`, @rptFileName , `number_of_copies`, `print_sequence`, `tax_invoice`,
`print_subreport`, dps.`inserted_by`, SYSDATE(), dps.`inserted_by_name`, dps.`last_upd_by`,
SYSDATE(), dps.`last_upd_by_name`, `take_address_from_branch_master` FROM document_print_setting dps
JOIN document_master dm 
ON dps.fk_document_master_id=dm.pk_document_master_id
WHERE document_type=@document_type AND print_file_name!=@rptFileName;
--------------------------------------------------------------------------------------------------------
-- ppms query
SELECT document_date,affect_stock,CONCAT(dh.`series`,'-',`doc_no`)AS doc_no,pure_Rate,gross_wt,dsd.`fk_from_loc_id`AS 'from_loc',dsd.`fk_to_loc_id`AS 'to_loc',id.`purity`,id.`fk_karagir_id` AS karagir_id,id.`fk_sub_karagir_id`AS 'sub_karagir_id', party_id,`total_stone_wt`,id.`small_stone_wt`,`total_stone_amount`,id.total_stone_amount_while_sales,dsd.other_charges AS "other charges",
`total_majuri`,`making_per_pcs` AS 'mak per pc',`making_per_gwt` AS 'mak per gw',`making_per_nwt`AS 'mak per NW',`making_lumpsum` AS 'mak per lmsm',`wastage_per_pcs` AS 'was per pc',`wastage_pct_per_gwt`AS 'was per GW',`wastage_pct_per_nwt`AS 'was per NW',`wastage_lumpsum` AS 'was lsm',
`total_enterprise_majuri`AS 'total E majuri',`enterprise_making_per_pcs`AS 'E mak per pc',`enterprise_making_per_gwt`AS 'E mak per gw',`enterprise_making_per_nwt`AS 'E mak per NW',`enterprise_making_lumpsum`AS 'E mak per lmsm',`enterprise_wastage_per_pcs`AS 'E was per pc',`enterprise_wastage_pct_per_gwt`AS 'E was per GW',`enterprse_wastage_pct_per_nwt`AS 'E was per NW',`enterprise_wastage_lumpsum`AS 'E was lsm'
FROM document_Stock_Details dsd 
JOIN document_header dh ON dsd.`fk_document_header_id`=dh.`pk_document_header_id` 
JOIN item_details id ON id.`pk_item_details_id`=dsd.`fk_item_detail_id` ORDER BY document_date DESC;

SELECT*FROM document_account_details ORDER BY 1 DESC; 
SELECT `pk_customization_master_id`,`name`,`for_internal_branch_code`AS branch_code,`for_document_type`,`for_internal_document_name`AS document_code,`is_active`FROM `customization_master`;
SELECT*FROM  document_header WHERE fk_document_type= 'journal_voucher'ORDER BY pk_document_header_id DESC;

SELECT*FROM document_master WHERE document_type='rd_sales';
SELECT*FROM document_master WHERE document_type='karagir_jama';

SELECT*FROM account_master ORDER BY 1 DESC;
SELECT`pk_account_master_id`,`account_name`,`is_tds_applicable`,`fk_tds_type_master_id`FROM account_master ORDER BY 1 DESC;
SELECT`pk_document_account_details_id`,`transaction_type`,`fk_account_id`,`debit_amount`,account_name,dad.`is_tds_applicable`,dad.`fk_tds_type_master_id`FROM document_account_details dad JOIN account_master ON`fk_account_id`=pk_account_master_id ORDER BY 1 DESC; 

---------------------------------------------------------------------------------------------------------------------

----20170628
-- scripts reg payment reports and receipt reports
SELECT document_date,CONCAT(dh.`series`,'-',`doc_no`)AS doc_no,`fk_document_header_id` AS 'Header Pk',`transaction_type`,`fk_account_id`,`debit_amount`,`credit_amount`,`reference_type`,`credit_days_credit`,`card_charges_pct_card`,`card_no_card`,`bank_name_cheque`,`date_on_cheque_cheque`,`our_bank_cheque`,`cheque_no_cheque`,`rtgs_no`,`neft_no`,`demand_draft_no`,`branch_name`
FROM document_account_Details dad 
JOIN document_header dh ON dad.`fk_document_header_id`=dh.`pk_document_header_id` 
WHERE dh.fk_document_type IN ('urd_purchase_voucher')AND transaction_type IN ('Cash') AND debit_amount IS NULL
ORDER BY pk_document_header_id DESC;

-- receipts
SELECT document_date,CONCAT(dh.`series`,'-',`doc_no`)AS doc_no,`fk_document_header_id` AS 'Header Pk',`transaction_type`,`fk_account_id`,`debit_amount`,`credit_amount`,`reference_type`,`credit_days_credit`,`card_charges_pct_card`,`card_no_card`,`bank_name_cheque`,`date_on_cheque_cheque`,`our_bank_cheque`,`cheque_no_cheque`,`rtgs_no`,`neft_no`,`demand_draft_no`,`branch_name`
FROM document_account_Details dad 
JOIN document_header dh ON dad.`fk_document_header_id`=dh.`pk_document_header_id` 
WHERE transaction_type IN ('Cheque') AND credit_amount IS NULL AND is_cancelled='N' AND STATUS='saved'
ORDER BY pk_document_header_id DESC;

SELECT SUM(debit_amount)
FROM document_account_Details dad 
JOIN document_header dh ON dad.`fk_document_header_id`=dh.`pk_document_header_id` 
WHERE  credit_amount IS NULL AND is_cancelled='N' AND STATUS='saved'AND cheque_no_cheque IS NOT NULL
GROUP BY transaction_type;



-- transaction type is null
SELECT document_date,CONCAT(dh.`series`,'-',`doc_no`)AS doc_no,`fk_document_header_id` AS 'Header Pk',`transaction_type`,`fk_account_id`,`debit_amount`,`credit_amount`,`reference_type`,`credit_days_credit`,`card_charges_pct_card`,`card_no_card`,`bank_name_cheque`,`date_on_cheque_cheque`,`our_bank_cheque`,`cheque_no_cheque`,`rtgs_no`,`neft_no`,`demand_draft_no`,`branch_name`
FROM document_account_Details dad 
JOIN document_header dh ON dad.`fk_document_header_id`=dh.`pk_document_header_id` 
WHERE transaction_type IS NULL AND credit_amount IS NULL AND is_cancelled='N' AND STATUS='saved'AND fk_account_id=1;
GROUP BY transaction_type;

-- -----------------------------------------------------------

SELECT document_date,CONCAT(dh.`series`,'-',`doc_no`)AS doc_no,`fk_document_header_id` AS 'Header Pk',`transaction_type`,`fk_account_id`,`debit_amount`,`credit_amount`,`reference_type`,`credit_days_credit`,`card_charges_pct_card`,`card_no_card`,`bank_name_cheque`,`date_on_cheque_cheque`,`our_bank_cheque`,`cheque_no_cheque`,`rtgs_no`,`neft_no`,`demand_draft_no`,`branch_name`
FROM document_account_Details dad 
JOIN document_header dh ON dad.`fk_document_header_id`=dh.`pk_document_header_id` 
WHERE dh.fk_document_type IN ('urd_purchase_voucher')AND transaction_type IN ('Cash') AND credit_amount IS NULL
ORDER BY pk_document_header_id DESC;

-- receipts
SELECT document_date,CONCAT(dh.`series`,'-',`doc_no`)AS doc_no,`fk_document_header_id` AS 'Header Pk',`transaction_type`,`fk_account_id`,`debit_amount`,`credit_amount`,`reference_type`,`credit_days_credit`,`card_charges_pct_card`,`card_no_card`,`bank_name_cheque`,`date_on_cheque_cheque`,`our_bank_cheque`,`cheque_no_cheque`,`rtgs_no`,`neft_no`,`demand_draft_no`,`branch_name`
FROM document_account_Details dad 
JOIN document_header dh ON dad.`fk_document_header_id`=dh.`pk_document_header_id` 
WHERE transaction_type IN ('Cheque') AND debit_amount IS NULL AND is_cancelled='N' AND STATUS='saved'
ORDER BY pk_document_header_id DESC;

SELECT SUM(credit_amount)
FROM document_account_Details dad 
JOIN document_header dh ON dad.`fk_document_header_id`=dh.`pk_document_header_id` 
WHERE  debit_amount IS NULL AND is_cancelled='N' AND STATUS='saved'AND fk_account_id=1
GROUP BY transaction_type;

-- transaction type is null
SELECT document_date,CONCAT(dh.`series`,'-',`doc_no`)AS doc_no,`fk_document_header_id` AS 'Header Pk',`transaction_type`,`fk_account_id`,`debit_amount`,`credit_amount`,`reference_type`,`credit_days_credit`,`card_charges_pct_card`,`card_no_card`,`bank_name_cheque`,`date_on_cheque_cheque`,`our_bank_cheque`,`cheque_no_cheque`,`rtgs_no`,`neft_no`,`demand_draft_no`,`branch_name`
FROM document_account_Details dad 
JOIN document_header dh ON dad.`fk_document_header_id`=dh.`pk_document_header_id` 
WHERE transaction_type IS NULL AND debit_amount IS NULL AND is_cancelled='N' AND STATUS='saved'AND fk_account_id=1;
GROUP BY transaction_type;

--  date format scripts
SELECT * FROM document_header WHERE `series`='GSB' AND `doc_no`BETWEEN '201' AND '244' AND `fy_year`='1718';

SELECT*FROM item_Details;
UPDATE document_header SET `document_date` = DATE_FORMAT(`document_date`, '%Y-04-%d') WHERE pk_document_header_id=389;

SELECT*FROM document_header WHERE DATE_FORMAT(`document_date`,'%Y%m%d')!=document_date_no; FROM document_header WHERE pk_document_header_id=389;


SELECT *FROM document_header WHERE auto_doc_source_no IN(SELECT pk_document_header_id FROM document_header WHERE `series`='GSB' AND `doc_no`BETWEEN '201' AND '244' AND `fy_year`='1718');

SELECT *FROM document_header WHERE auto_doc_source_no IN(SELECT pk_document_header_id FROM document_header WHERE `series`='GSB' AND `doc_no`BETWEEN '201' AND '244' AND `fy_year`='1718');


SELECT*FROM document_header WHERE DATE_FORMAT(`document_date`,'%Y%m%d')!=document_date_no;

-- 

SELECT pk_item_Details_id, pk_document_header_id,`document_date`,`series`,`doc_no`,fk_document_type, `fk_from_loc_id`,`fk_to_loc_id`,document_stock_details.`status`,item_details.`purity`,fk_purity_id,`urd_purity`FROM document_Stock_Details JOIN document_header ON `fk_document_header_id`=`pk_document_header_id` JOIN item_details ON `pk_item_details_id`=`fk_item_detail_id` WHERE `fk_from_loc_id`IS NULL AND`fk_to_loc_id` IS NULL AND document_header.is_cancelled='N' OR series='SRDP';
SELECT * FROM document_print_setting RIGHT JOIN document_master ON pk_document_master_id=fk_document_master_id WHERE document_type='urd_purchase_voucher'; 
SELECT * FROM document_print_setting;
SELECT * FROM document_stock_details  JOIN document_header ON pk_document_header_id=fk_document_header_id WHERE series='SRDP' ;AND doc_no='3'; 

-- other quieries
-- item master , id, dh,dad joint, 
SELECT pk_document_header_id,`document_date`,`series`,`doc_no` ,`pk_item_details_id`,fk_purity_id,gross_wt,net_wt,pcs,fk_metal_name, fk_item_id, item_name FROM document_header dh
JOIN document_stock_details ON `fk_document_header_id`=`pk_document_header_id` 
JOIN item_details ON `pk_item_details_id`=`fk_item_detail_id` 
JOIN item_master ON pk_item_master_id =fk_item_id  WHERE fk_item_id IN (3920,3921,3922,3923,3924); ORDER BY 1 DESC; 

-- inner query to update data from same table
UPDATE document_header s INNER JOIN document_header t ON
s.fk_ptr_header = t.pk_document_header_id 
SET s.party_id = t.party_id 
WHERE s.fk_document_type IN ('girvi_borrow')
AND t.fk_document_type = 'girvi_account_open';

-- syntax 
(
update ud 
  set assid = (
               select sale.assid 
                 from sale 
                where sale.udid = ud.id
              )
 where exists (
               select * 
                 from sale 
                where sale.udid = ud.id
              );
)
(

update ud u
inner join sale s on
    u.id = s.udid
set u.assid = s.assid

)









