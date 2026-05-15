/*
** ORCHA AGENT OS: ENTERPRISE ERP SAMPLE (145 TABLES)
** Target: MSSQL Server
** Pattern: professional-executable-script (instnwnd.sql style)
** Region: Philippines (Compliance Ready)
** Style: Zoho Inventory DB Approach
** Note: Programmatic mass-seeding (20-30 records per table)
*/

SET NOCOUNT ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET DATEFORMAT ymd
GO

-- ============================================================================
-- 1. CLEANUP SECTION (Drop in reverse dependency order)
-- ============================================================================

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.sys_user_sessions') AND sysstat & 0xf = 3) DROP TABLE "dbo"."sys_user_sessions"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.sys_api_logs') AND sysstat & 0xf = 3) DROP TABLE "dbo"."sys_api_logs"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.sys_integration_configs') AND sysstat & 0xf = 3) DROP TABLE "dbo"."sys_integration_configs"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.sys_audit_log_entries') AND sysstat & 0xf = 3) DROP TABLE "dbo"."sys_audit_log_entries"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.budget_variances') AND sysstat & 0xf = 3) DROP TABLE "dbo"."budget_variances"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.budget_allocations') AND sysstat & 0xf = 3) DROP TABLE "dbo"."budget_allocations"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.compliance_audit_logs') AND sysstat & 0xf = 3) DROP TABLE "dbo"."compliance_audit_logs"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.corrective_actions') AND sysstat & 0xf = 3) DROP TABLE "dbo"."corrective_actions"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.non_conformance_reports') AND sysstat & 0xf = 3) DROP TABLE "dbo"."non_conformance_reports"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.inspection_results') AND sysstat & 0xf = 3) DROP TABLE "dbo"."inspection_results"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.procurement_bid_evaluation') AND sysstat & 0xf = 3) DROP TABLE "dbo"."procurement_bid_evaluation"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.procurement_vendor_responses') AND sysstat & 0xf = 3) DROP TABLE "dbo"."procurement_vendor_responses"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.procurement_rfq_items') AND sysstat & 0xf = 3) DROP TABLE "dbo"."procurement_rfq_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.procurement_rfqs') AND sysstat & 0xf = 3) DROP TABLE "dbo"."procurement_rfqs"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.purchase_contract_items') AND sysstat & 0xf = 3) DROP TABLE "dbo"."purchase_contract_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.purchase_contracts') AND sysstat & 0xf = 3) DROP TABLE "dbo"."purchase_contracts"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.hr_performance_reviews') AND sysstat & 0xf = 3) DROP TABLE "dbo"."hr_performance_reviews"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.hr_employee_certifications') AND sysstat & 0xf = 3) DROP TABLE "dbo"."hr_employee_certifications"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.hr_interview_results') AND sysstat & 0xf = 3) DROP TABLE "dbo"."hr_interview_results"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.hr_interviews') AND sysstat & 0xf = 3) DROP TABLE "dbo"."hr_interviews"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.hr_job_applicants') AND sysstat & 0xf = 3) DROP TABLE "dbo"."hr_job_applicants"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.hr_job_postings') AND sysstat & 0xf = 3) DROP TABLE "dbo"."hr_job_postings"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.crm_quotation_items') AND sysstat & 0xf = 3) DROP TABLE "dbo"."crm_quotation_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.crm_sales_quotations') AND sysstat & 0xf = 3) DROP TABLE "dbo"."crm_sales_quotations"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.crm_opportunities') AND sysstat & 0xf = 3) DROP TABLE "dbo"."crm_opportunities"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.crm_leads') AND sysstat & 0xf = 3) DROP TABLE "dbo"."crm_leads"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.asset_custodians') AND sysstat & 0xf = 3) DROP TABLE "dbo"."asset_custodians"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.asset_maintenance_contracts') AND sysstat & 0xf = 3) DROP TABLE "dbo"."asset_maintenance_contracts"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.asset_transfers') AND sysstat & 0xf = 3) DROP TABLE "dbo"."asset_transfers"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.asset_disposals') AND sysstat & 0xf = 3) DROP TABLE "dbo"."asset_disposals"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.asset_depreciation_logs') AND sysstat & 0xf = 3) DROP TABLE "dbo"."asset_depreciation_logs"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.fixed_assets') AND sysstat & 0xf = 3) DROP TABLE "dbo"."fixed_assets"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.asset_depreciation_methods') AND sysstat & 0xf = 3) DROP TABLE "dbo"."asset_depreciation_methods"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.asset_categories') AND sysstat & 0xf = 3) DROP TABLE "dbo"."asset_categories"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.crm_contact_interactions') AND sysstat & 0xf = 3) DROP TABLE "dbo"."crm_contact_interactions"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.crm_competitors') AND sysstat & 0xf = 3) DROP TABLE "dbo"."crm_competitors"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.crm_opportunity_stages') AND sysstat & 0xf = 3) DROP TABLE "dbo"."crm_opportunity_stages"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.crm_lead_sources') AND sysstat & 0xf = 3) DROP TABLE "dbo"."crm_lead_sources"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.marketing_campaigns') AND sysstat & 0xf = 3) DROP TABLE "dbo"."marketing_campaigns"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.crm_sales_territories') AND sysstat & 0xf = 3) DROP TABLE "dbo"."crm_sales_territories"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.hr_training_courses') AND sysstat & 0xf = 3) DROP TABLE "dbo"."hr_training_courses"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.hr_onboarding_checklists') AND sysstat & 0xf = 3) DROP TABLE "dbo"."hr_onboarding_checklists"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.hr_applicant_statuses') AND sysstat & 0xf = 3) DROP TABLE "dbo"."hr_applicant_statuses"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.supplier_audit_logs') AND sysstat & 0xf = 3) DROP TABLE "dbo"."supplier_audit_logs"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.supplier_evaluation_criteria') AND sysstat & 0xf = 3) DROP TABLE "dbo"."supplier_evaluation_criteria"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.quality_test_definitions') AND sysstat & 0xf = 3) DROP TABLE "dbo"."quality_test_definitions"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.quality_test_groups') AND sysstat & 0xf = 3) DROP TABLE "dbo"."quality_test_groups"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.quality_control_plans') AND sysstat & 0xf = 3) DROP TABLE "dbo"."quality_control_plans"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.compliance_regulations') AND sysstat & 0xf = 3) DROP TABLE "dbo"."compliance_regulations"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.cost_centers') AND sysstat & 0xf = 3) DROP TABLE "dbo"."cost_centers"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.budget_periods') AND sysstat & 0xf = 3) DROP TABLE "dbo"."budget_periods"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.finance_tax_rules') AND sysstat & 0xf = 3) DROP TABLE "dbo"."finance_tax_rules"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.finance_currency_rates') AND sysstat & 0xf = 3) DROP TABLE "dbo"."finance_currency_rates"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.sys_branches') AND sysstat & 0xf = 3) DROP TABLE "dbo"."sys_branches"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.sys_entities') AND sysstat & 0xf = 3) DROP TABLE "dbo"."sys_entities"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.sys_notification_templates') AND sysstat & 0xf = 3) DROP TABLE "dbo"."sys_notification_templates"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.sys_document_sequences') AND sysstat & 0xf = 3) DROP TABLE "dbo"."sys_document_sequences"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.sys_maintenance_mode') AND sysstat & 0xf = 3) DROP TABLE "dbo"."sys_maintenance_mode"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.sys_app_settings') AND sysstat & 0xf = 3) DROP TABLE "dbo"."sys_app_settings"
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_timesheet_entries') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_timesheet_entries"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_timesheets') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_timesheets"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_task_dependencies') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_task_dependencies"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_task_attachments') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_task_attachments"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_task_comments') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_task_comments"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_task_assignees') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_task_assignees"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_tasks') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_tasks"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_task_types') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_task_types"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_task_priorities') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_task_priorities"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_milestones') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_milestones"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_members') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_members"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_member_roles') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_member_roles"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_budgets') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_budgets"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.projects') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."projects"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_statuses') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_statuses"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.project_types') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."project_types"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_kb_article_votes') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_kb_article_votes"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_kb_articles') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_kb_articles"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_kb_categories') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_kb_categories"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_satisfaction_surveys') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_satisfaction_surveys"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_ticket_slas') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_ticket_slas"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_sla_targets') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_sla_targets"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_sla_policies') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_sla_policies"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_ticket_attachments') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_ticket_attachments"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_ticket_comments') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_ticket_comments"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_ticket_tags') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_ticket_tags"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_tickets') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_tickets"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_agent_assignments') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_agent_assignments"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_agent_groups') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_agent_groups"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_channels') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_channels"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_ticket_statuses') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_ticket_statuses"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_ticket_priorities') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_ticket_priorities"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.support_canned_responses') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."support_canned_responses"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.driver_performance_logs') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."driver_performance_logs"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.driver_licenses') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."driver_licenses"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.vehicle_tolls') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."vehicle_tolls"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.gps_logs') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."gps_logs"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.delivery_stops') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."delivery_stops"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.delivery_routes') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."delivery_routes"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.vehicle_incidents') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."vehicle_incidents"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.vehicle_registrations') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."vehicle_registrations"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.vehicle_documents') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."vehicle_documents"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.vehicle_insurances') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."vehicle_insurances"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.vehicle_maintenance_logs') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."vehicle_maintenance_logs"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.vehicle_maintenance_types') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."vehicle_maintenance_types"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.fuel_logs') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."fuel_logs"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.vehicle_assignments') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."vehicle_assignments"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.vehicles') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."vehicles"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.vehicle_types') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."vehicle_types"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.machine_downtime') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."machine_downtime"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.downtime_reasons') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."downtime_reasons"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.inspection_results') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."inspection_results"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.quality_inspections') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."quality_inspections"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.quality_parameters') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."quality_parameters"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.maintenance_logs') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."maintenance_logs"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.maintenance_schedules') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."maintenance_schedules"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.machines') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."machines"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.machine_types') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."machine_types"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.scrap_management') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."scrap_management"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.mo_finished_goods_receipts') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."mo_finished_goods_receipts"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.mo_material_issues') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."mo_material_issues"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.material_requests') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."material_requests"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.work_order_logs') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."work_order_logs"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.work_orders') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."work_orders"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.mo_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."mo_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.manufacturing_orders') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."manufacturing_orders"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.bom_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."bom_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.bill_of_materials') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."bill_of_materials"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.routing_operations') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."routing_operations"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.routing_plans') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."routing_plans"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.work_center_resources') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."work_center_resources"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.production_lines') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."production_lines"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.work_centers') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."work_centers"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.expense_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."expense_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.expenses') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."expenses"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.vendor_credit_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."vendor_credit_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.vendor_credits') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."vendor_credits"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.vendor_payments') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."vendor_payments"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.bill_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."bill_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.bills') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."bills"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.credit_note_refunds') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."credit_note_refunds"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.credit_note_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."credit_note_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.credit_notes') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."credit_notes"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.customer_payments') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."customer_payments"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.invoice_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."invoice_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.invoices') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."invoices"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.shipment_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."shipment_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.shipments') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."shipments"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.package_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."package_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.packages') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."packages"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.sales_order_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."sales_order_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.sales_orders') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."sales_orders"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.customer_addresses') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."customer_addresses"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.customer_contacts') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."customer_contacts"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.customers') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."customers"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.customer_groups') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."customer_groups"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.price_lists') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."price_lists"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.stock_adjustment_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."stock_adjustment_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.stock_adjustments') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."stock_adjustments"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.stock_adjustment_reasons') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."stock_adjustment_reasons"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.transfer_order_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."transfer_order_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.transfer_orders') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."transfer_orders"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.serial_numbers') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."serial_numbers"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.batch_numbers') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."batch_numbers"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.stock_levels') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."stock_levels"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.stock_locations') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."stock_locations"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.warehouses') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."warehouses"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.composite_item_members') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."composite_item_members"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.item_groups') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."item_groups"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.uom_conversions') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."uom_conversions"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.uom') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."uom"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.payroll_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."payroll_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.payroll_runs') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."payroll_runs"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.attendance_logs') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."attendance_logs"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.overtime_requests') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."overtime_requests"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.employee_assets') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."employee_assets"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.employee_onboarding_status') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."employee_onboarding_status"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.onboarding_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."onboarding_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.employee_documents') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."employee_documents"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.employee_government_ids') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."employee_government_ids"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.employee_contracts') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."employee_contracts"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.holidays') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."holidays"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.purchase_order_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."purchase_order_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.purchase_orders') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."purchase_orders"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.supplier_contacts') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."supplier_contacts"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.suppliers') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."suppliers"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.leave_requests') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."leave_requests"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.leave_types') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."leave_types"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.employees') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."employees"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.positions') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."positions"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.departments') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."departments"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.journal_items') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."journal_items"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.journal_entries') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."journal_entries"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.journals') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."journals"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.chart_of_accounts') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."chart_of_accounts"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.fiscal_years') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."fiscal_years"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.user_roles') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."user_roles"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.role_permissions') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."role_permissions"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.permissions') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."permissions"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.roles') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."roles"
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.users') AND sysstat & 0xf = 3)
	DROP TABLE "dbo"."users"
GO

-- ============================================================================
-- 2. CREATE TABLES SECTION
-- ============================================================================

CREATE TABLE "dbo"."users" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "username" NVARCHAR(50) UNIQUE NOT NULL,
    "email" NVARCHAR(100) UNIQUE NOT NULL,
    "password_hash" NVARCHAR(MAX) NOT NULL,
    "first_name" NVARCHAR(50) NULL,
    "last_name" NVARCHAR(50) NULL,
    "active_flag" BIT DEFAULT 1,
    "last_login_at" DATETIME NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."roles" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(50) UNIQUE NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "is_system" BIT DEFAULT 0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."permissions" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "code" NVARCHAR(100) UNIQUE NOT NULL,
    "name" NVARCHAR(100) NOT NULL,
    "module" NVARCHAR(50) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."role_permissions" (
    "role_id" INT NOT NULL,
    "permission_id" INT NOT NULL,
    PRIMARY KEY ("role_id", "permission_id"),
    "created_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_role_permissions_roles" FOREIGN KEY ("role_id") REFERENCES "dbo"."roles"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_role_permissions_perms" FOREIGN KEY ("permission_id") REFERENCES "dbo"."permissions"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."user_roles" (
    "user_id" INT NOT NULL,
    "role_id" INT NOT NULL,
    PRIMARY KEY ("user_id", "role_id"),
    "created_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_user_roles_users" FOREIGN KEY ("user_id") REFERENCES "dbo"."users"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_user_roles_roles" FOREIGN KEY ("role_id") REFERENCES "dbo"."roles"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."fiscal_years" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(20) NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "is_closed" BIT DEFAULT 0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."chart_of_accounts" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "code" NVARCHAR(20) UNIQUE NOT NULL,
    "name" NVARCHAR(100) NOT NULL,
    "type" NVARCHAR(20) CHECK (type IN ('asset', 'liability', 'equity', 'revenue', 'expense')),
    "parent_id" INT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_coa_parent" FOREIGN KEY ("parent_id") REFERENCES "dbo"."chart_of_accounts"("id")
)
GO

CREATE TABLE "dbo"."journals" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(50) NOT NULL,
    "code" NVARCHAR(10) UNIQUE NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."journal_entries" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "fiscal_year_id" INT NULL,
    "journal_id" INT NULL,
    "entry_date" DATE NOT NULL,
    "reference_no" NVARCHAR(50) NULL,
    "description" NVARCHAR(MAX) NULL,
    "status" NVARCHAR(20) DEFAULT 'draft',
    "created_by" INT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    "active_flag" BIT DEFAULT 1,
    CONSTRAINT "FK_je_fy" FOREIGN KEY ("fiscal_year_id") REFERENCES "dbo"."fiscal_years"("id"),
    CONSTRAINT "FK_je_journal" FOREIGN KEY ("journal_id") REFERENCES "dbo"."journals"("id"),
    CONSTRAINT "FK_je_user" FOREIGN KEY ("created_by") REFERENCES "dbo"."users"("id")
)
GO

CREATE TABLE "dbo"."journal_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "entry_id" INT NOT NULL,
    "account_id" INT NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "debit" DECIMAL(18, 4) DEFAULT 0,
    "credit" DECIMAL(18, 4) DEFAULT 0,
    "reconciled" BIT DEFAULT 0,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_ji_entry" FOREIGN KEY ("entry_id") REFERENCES "dbo"."journal_entries"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_ji_account" FOREIGN KEY ("account_id") REFERENCES "dbo"."chart_of_accounts"("id")
)
GO

-- ============================================================================
-- 3. INVENTORY & WAREHOUSE (Zoho Inventory Style)
-- ============================================================================

CREATE TABLE "dbo"."uom" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(50) NOT NULL,
    "abbreviation" NVARCHAR(10) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."uom_conversions" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "from_uom_id" INT NOT NULL,
    "to_uom_id" INT NOT NULL,
    "conversion_factor" DECIMAL(18, 8) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_uom_from" FOREIGN KEY ("from_uom_id") REFERENCES "dbo"."uom"("id"),
    CONSTRAINT "FK_uom_to" FOREIGN KEY ("to_uom_id") REFERENCES "dbo"."uom"("id")
)
GO

CREATE TABLE "dbo"."item_groups" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "attribute_type" NVARCHAR(50) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "item_group_id" INT NULL,
    "name" NVARCHAR(200) NOT NULL,
    "sku" NVARCHAR(100) UNIQUE NOT NULL,
    "upc" NVARCHAR(50) NULL,
    "description" NVARCHAR(MAX) NULL,
    "purchase_price" DECIMAL(18, 4) DEFAULT 0,
    "selling_price" DECIMAL(18, 4) DEFAULT 0,
    "uom_id" INT NOT NULL,
    "item_type" NVARCHAR(20) DEFAULT 'sales',
    "is_inventory_tracking" BIT DEFAULT 1,
    "reorder_level" DECIMAL(18, 2) DEFAULT 0,
    "initial_stock" DECIMAL(18, 2) DEFAULT 0,
    "brand" NVARCHAR(100) NULL,
    "manufacturer" NVARCHAR(100) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_item_group" FOREIGN KEY ("item_group_id") REFERENCES "dbo"."item_groups"("id"),
    CONSTRAINT "FK_item_uom" FOREIGN KEY ("uom_id") REFERENCES "dbo"."uom"("id")
)
GO

CREATE TABLE "dbo"."composite_item_members" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "composite_item_id" INT NOT NULL,
    "member_item_id" INT NOT NULL,
    "quantity" DECIMAL(18, 4) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_composite_main" FOREIGN KEY ("composite_item_id") REFERENCES "dbo"."items"("id"),
    CONSTRAINT "FK_composite_member" FOREIGN KEY ("member_item_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."warehouses" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "code" NVARCHAR(20) UNIQUE NOT NULL,
    "address" NVARCHAR(MAX) NULL,
    "city" NVARCHAR(50) NULL,
    "is_primary" BIT DEFAULT 0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."stock_locations" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "warehouse_id" INT NOT NULL,
    "name" NVARCHAR(100) NOT NULL,
    "parent_location_id" INT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_loc_warehouse" FOREIGN KEY ("warehouse_id") REFERENCES "dbo"."warehouses"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_loc_parent" FOREIGN KEY ("parent_location_id") REFERENCES "dbo"."stock_locations"("id")
)
GO

CREATE TABLE "dbo"."stock_levels" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "item_id" INT NOT NULL,
    "warehouse_id" INT NOT NULL,
    "stock_on_hand" DECIMAL(18, 4) DEFAULT 0,
    "available_stock" DECIMAL(18, 4) DEFAULT 0,
    "committed_stock" DECIMAL(18, 4) DEFAULT 0,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_stock_item" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id"),
    CONSTRAINT "FK_stock_warehouse" FOREIGN KEY ("warehouse_id") REFERENCES "dbo"."warehouses"("id")
)
GO

CREATE TABLE "dbo"."batch_numbers" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "item_id" INT NOT NULL,
    "batch_number" NVARCHAR(100) NOT NULL,
    "expiry_date" DATE NULL,
    "manufacturing_date" DATE NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_batch_item" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."serial_numbers" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "item_id" INT NOT NULL,
    "serial_number" NVARCHAR(100) UNIQUE NOT NULL,
    "status" NVARCHAR(20) DEFAULT 'available',
    "warehouse_id" INT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_serial_item" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id"),
    CONSTRAINT "FK_serial_warehouse" FOREIGN KEY ("warehouse_id") REFERENCES "dbo"."warehouses"("id")
)
GO

-- ─── INVENTORY ADJUSTMENTS ──────────────────────────────────────────────

CREATE TABLE "dbo"."stock_adjustment_reasons" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "reason_name" NVARCHAR(100) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."stock_adjustments" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "adjustment_no" NVARCHAR(50) UNIQUE NOT NULL,
    "adjustment_date" DATE NOT NULL,
    "reason_id" INT NOT NULL,
    "warehouse_id" INT NOT NULL,
    "account_id" INT NULL,
    "reference_no" NVARCHAR(100) NULL,
    "description" NVARCHAR(MAX) NULL,
    "status" NVARCHAR(20) DEFAULT 'draft',
    "created_by" INT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_adj_reason" FOREIGN KEY ("reason_id") REFERENCES "dbo"."stock_adjustment_reasons"("id"),
    CONSTRAINT "FK_adj_warehouse" FOREIGN KEY ("warehouse_id") REFERENCES "dbo"."warehouses"("id"),
    CONSTRAINT "FK_adj_coa" FOREIGN KEY ("account_id") REFERENCES "dbo"."chart_of_accounts"("id"),
    CONSTRAINT "FK_adj_user" FOREIGN KEY ("created_by") REFERENCES "dbo"."users"("id")
)
GO

CREATE TABLE "dbo"."stock_adjustment_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "adjustment_id" INT NOT NULL,
    "item_id" INT NOT NULL,
    "quantity_adjusted" DECIMAL(18, 4) NOT NULL,
    "valuation_adjustment" DECIMAL(18, 4) DEFAULT 0,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_adj_item_main" FOREIGN KEY ("adjustment_id") REFERENCES "dbo"."stock_adjustments"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_adj_item_link" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."transfer_orders" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "order_no" NVARCHAR(50) UNIQUE NOT NULL,
    "source_warehouse_id" INT NOT NULL,
    "destination_warehouse_id" INT NOT NULL,
    "transfer_date" DATE NOT NULL,
    "status" NVARCHAR(20) DEFAULT 'draft',
    "reason" NVARCHAR(MAX) NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    "active_flag" BIT DEFAULT 1,
    CONSTRAINT "FK_trans_source" FOREIGN KEY ("source_warehouse_id") REFERENCES "dbo"."warehouses"("id"),
    CONSTRAINT "FK_trans_dest" FOREIGN KEY ("destination_warehouse_id") REFERENCES "dbo"."warehouses"("id")
)
GO

CREATE TABLE "dbo"."transfer_order_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "transfer_order_id" INT NOT NULL,
    "item_id" INT NOT NULL,
    "quantity" DECIMAL(18, 4) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_trans_item_order" FOREIGN KEY ("transfer_order_id") REFERENCES "dbo"."transfer_orders"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_trans_item_link" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id")
)
GO

-- ============================================================================
-- 4. SALES & CRM (Zoho Inventory Style)
-- ============================================================================

CREATE TABLE "dbo"."customer_groups" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."price_lists" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "currency_code" NVARCHAR(3) DEFAULT 'PHP',
    "is_percentage" BIT DEFAULT 0,
    "value" DECIMAL(18, 4) DEFAULT 0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."customers" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "customer_group_id" INT NULL,
    "price_list_id" INT NULL,
    "name" NVARCHAR(200) NOT NULL,
    "display_name" NVARCHAR(200) NULL,
    "email" NVARCHAR(100) NULL,
    "phone" NVARCHAR(20) NULL,
    "tax_id" NVARCHAR(50) NULL,
    "website" NVARCHAR(MAX) NULL,
    "type" NVARCHAR(20) DEFAULT 'business',
    "payment_terms" NVARCHAR(50) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_cust_group" FOREIGN KEY ("customer_group_id") REFERENCES "dbo"."customer_groups"("id"),
    CONSTRAINT "FK_cust_pricelist" FOREIGN KEY ("price_list_id") REFERENCES "dbo"."price_lists"("id")
)
GO

CREATE TABLE "dbo"."customer_contacts" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "customer_id" INT NOT NULL,
    "first_name" NVARCHAR(50) NOT NULL,
    "last_name" NVARCHAR(50) NOT NULL,
    "email" NVARCHAR(100) NULL,
    "phone" NVARCHAR(20) NULL,
    "mobile" NVARCHAR(20) NULL,
    "is_primary" BIT DEFAULT 0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_contact_cust" FOREIGN KEY ("customer_id") REFERENCES "dbo"."customers"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."customer_addresses" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "customer_id" INT NOT NULL,
    "address_type" NVARCHAR(20) DEFAULT 'shipping',
    "attention" NVARCHAR(100) NULL,
    "address" NVARCHAR(MAX) NOT NULL,
    "city" NVARCHAR(50) NULL,
    "province" NVARCHAR(50) NULL,
    "zip_code" NVARCHAR(10) NULL,
    "country" NVARCHAR(50) DEFAULT 'Philippines',
    "phone" NVARCHAR(20) NULL,
    "is_default" BIT DEFAULT 0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_addr_cust" FOREIGN KEY ("customer_id") REFERENCES "dbo"."customers"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."sales_orders" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "customer_id" INT NOT NULL,
    "so_no" NVARCHAR(50) UNIQUE NOT NULL,
    "order_date" DATE NOT NULL,
    "shipment_date" DATE NULL,
    "reference_no" NVARCHAR(100) NULL,
    "status" NVARCHAR(20) DEFAULT 'draft',
    "total_amount" DECIMAL(18, 4) DEFAULT 0,
    "notes" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_so_cust" FOREIGN KEY ("customer_id") REFERENCES "dbo"."customers"("id")
)
GO

CREATE TABLE "dbo"."sales_order_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "sales_order_id" INT NOT NULL,
    "item_id" INT NOT NULL,
    "quantity" DECIMAL(18, 4) NOT NULL,
    "rate" DECIMAL(18, 4) NOT NULL,
    "discount" DECIMAL(18, 4) DEFAULT 0,
    "tax_amount" DECIMAL(18, 4) DEFAULT 0,
    "total_amount" DECIMAL(18, 4) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_so_item_order" FOREIGN KEY ("sales_order_id") REFERENCES "dbo"."sales_orders"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_so_item_link" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."packages" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "sales_order_id" INT NOT NULL,
    "package_no" NVARCHAR(50) UNIQUE NOT NULL,
    "package_date" DATE NOT NULL,
    "notes" NVARCHAR(MAX) NULL,
    "status" NVARCHAR(20) DEFAULT 'not_shipped',
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_pkg_so" FOREIGN KEY ("sales_order_id") REFERENCES "dbo"."sales_orders"("id")
)
GO

CREATE TABLE "dbo"."package_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "package_id" INT NOT NULL,
    "sales_order_item_id" INT NOT NULL,
    "quantity_packed" DECIMAL(18, 4) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_pkg_item_main" FOREIGN KEY ("package_id") REFERENCES "dbo"."packages"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_pkg_item_link" FOREIGN KEY ("sales_order_item_id") REFERENCES "dbo"."sales_order_items"("id")
)
GO

CREATE TABLE "dbo"."shipments" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "sales_order_id" INT NOT NULL,
    "shipment_no" NVARCHAR(50) UNIQUE NOT NULL,
    "shipment_date" DATE NOT NULL,
    "delivery_method" NVARCHAR(50) NULL,
    "tracking_no" NVARCHAR(100) NULL,
    "notes" NVARCHAR(MAX) NULL,
    "status" NVARCHAR(20) DEFAULT 'shipped',
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_ship_so" FOREIGN KEY ("sales_order_id") REFERENCES "dbo"."sales_orders"("id")
)
GO

CREATE TABLE "dbo"."shipment_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "shipment_id" INT NOT NULL,
    "package_id" INT NULL,
    "sales_order_item_id" INT NOT NULL,
    "quantity_shipped" DECIMAL(18, 4) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_ship_item_main" FOREIGN KEY ("shipment_id") REFERENCES "dbo"."shipments"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_ship_item_link" FOREIGN KEY ("sales_order_item_id") REFERENCES "dbo"."sales_order_items"("id"),
    CONSTRAINT "FK_ship_item_pkg" FOREIGN KEY ("package_id") REFERENCES "dbo"."packages"("id")
)
GO

-- ============================================================================
-- 5. FINANCE & ACCOUNTING (Accounts Receivable & Payable)
-- ============================================================================

CREATE TABLE "dbo"."invoices" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "customer_id" INT NOT NULL,
    "sales_order_id" INT NULL,
    "invoice_no" NVARCHAR(50) UNIQUE NOT NULL,
    "invoice_date" DATE NOT NULL,
    "due_date" DATE NOT NULL,
    "status" NVARCHAR(20) DEFAULT 'draft',
    "total_amount" DECIMAL(18, 4) NOT NULL,
    "balance_due" DECIMAL(18, 4) NOT NULL,
    "notes" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_inv_cust" FOREIGN KEY ("customer_id") REFERENCES "dbo"."customers"("id"),
    CONSTRAINT "FK_inv_so" FOREIGN KEY ("sales_order_id") REFERENCES "dbo"."sales_orders"("id")
)
GO

CREATE TABLE "dbo"."invoice_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "invoice_id" INT NOT NULL,
    "item_id" INT NOT NULL,
    "quantity" DECIMAL(18, 4) NOT NULL,
    "rate" DECIMAL(18, 4) NOT NULL,
    "tax_amount" DECIMAL(18, 4) DEFAULT 0,
    "total_amount" DECIMAL(18, 4) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_inv_item_main" FOREIGN KEY ("invoice_id") REFERENCES "dbo"."invoices"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_inv_item_link" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."customer_payments" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "customer_id" INT NOT NULL,
    "invoice_id" INT NULL,
    "payment_no" NVARCHAR(50) UNIQUE NOT NULL,
    "payment_date" DATE NOT NULL,
    "payment_method" NVARCHAR(50) NULL,
    "amount_received" DECIMAL(18, 4) NOT NULL,
    "bank_charges" DECIMAL(18, 4) DEFAULT 0,
    "reference_no" NVARCHAR(100) NULL,
    "notes" NVARCHAR(MAX) NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_pay_cust" FOREIGN KEY ("customer_id") REFERENCES "dbo"."customers"("id"),
    CONSTRAINT "FK_pay_inv" FOREIGN KEY ("invoice_id") REFERENCES "dbo"."invoices"("id")
)
GO

CREATE TABLE "dbo"."credit_notes" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "customer_id" INT NOT NULL,
    "credit_note_no" NVARCHAR(50) UNIQUE NOT NULL,
    "credit_note_date" DATE NOT NULL,
    "status" NVARCHAR(20) DEFAULT 'open',
    "total_amount" DECIMAL(18, 4) NOT NULL,
    "balance" DECIMAL(18, 4) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_cn_cust" FOREIGN KEY ("customer_id") REFERENCES "dbo"."customers"("id")
)
GO

CREATE TABLE "dbo"."credit_note_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "credit_note_id" INT NOT NULL,
    "item_id" INT NOT NULL,
    "quantity" DECIMAL(18, 4) NOT NULL,
    "rate" DECIMAL(18, 4) NOT NULL,
    "total_amount" DECIMAL(18, 4) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_cn_item_main" FOREIGN KEY ("credit_note_id") REFERENCES "dbo"."credit_notes"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_cn_item_link" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."credit_note_refunds" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "credit_note_id" INT NOT NULL,
    "refund_date" DATE NOT NULL,
    "payment_method" NVARCHAR(50) NULL,
    "amount_refunded" DECIMAL(18, 4) NOT NULL,
    "reference_no" NVARCHAR(100) NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_cn_refund_main" FOREIGN KEY ("credit_note_id") REFERENCES "dbo"."credit_notes"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."bills" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "supplier_id" INT NOT NULL,
    "purchase_order_id" INT NULL,
    "bill_no" NVARCHAR(50) NOT NULL,
    "bill_date" DATE NOT NULL,
    "due_date" DATE NOT NULL,
    "status" NVARCHAR(20) DEFAULT 'draft',
    "total_amount" DECIMAL(18, 4) NOT NULL,
    "balance_due" DECIMAL(18, 4) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_bill_supplier" FOREIGN KEY ("supplier_id") REFERENCES "dbo"."suppliers"("id"),
    CONSTRAINT "FK_bill_po" FOREIGN KEY ("purchase_order_id") REFERENCES "dbo"."purchase_orders"("id")
)
GO

CREATE TABLE "dbo"."bill_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "bill_id" INT NOT NULL,
    "item_id" INT NOT NULL,
    "quantity" DECIMAL(18, 4) NOT NULL,
    "rate" DECIMAL(18, 4) NOT NULL,
    "total_amount" DECIMAL(18, 4) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_bill_item_main" FOREIGN KEY ("bill_id") REFERENCES "dbo"."bills"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_bill_item_link" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."vendor_payments" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "supplier_id" INT NOT NULL,
    "bill_id" INT NULL,
    "payment_no" NVARCHAR(50) UNIQUE NOT NULL,
    "payment_date" DATE NOT NULL,
    "payment_method" NVARCHAR(50) NULL,
    "amount_paid" DECIMAL(18, 4) NOT NULL,
    "reference_no" NVARCHAR(100) NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_vpay_supplier" FOREIGN KEY ("supplier_id") REFERENCES "dbo"."suppliers"("id"),
    CONSTRAINT "FK_vpay_bill" FOREIGN KEY ("bill_id") REFERENCES "dbo"."bills"("id")
)
GO

CREATE TABLE "dbo"."vendor_credits" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "supplier_id" INT NOT NULL,
    "credit_no" NVARCHAR(50) UNIQUE NOT NULL,
    "credit_date" DATE NOT NULL,
    "status" NVARCHAR(20) DEFAULT 'open',
    "total_amount" DECIMAL(18, 4) NOT NULL,
    "balance" DECIMAL(18, 4) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_vc_supplier" FOREIGN KEY ("supplier_id") REFERENCES "dbo"."suppliers"("id")
)
GO

CREATE TABLE "dbo"."vendor_credit_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "vendor_credit_id" INT NOT NULL,
    "item_id" INT NOT NULL,
    "quantity" DECIMAL(18, 4) NOT NULL,
    "rate" DECIMAL(18, 4) NOT NULL,
    "total_amount" DECIMAL(18, 4) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_vc_item_main" FOREIGN KEY ("vendor_credit_id") REFERENCES "dbo"."vendor_credits"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_vc_item_link" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."expenses" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "employee_id" INT NULL,
    "expense_date" DATE NOT NULL,
    "category_id" INT NULL,
    "amount" DECIMAL(18, 4) NOT NULL,
    "payment_method" NVARCHAR(50) NULL,
    "reference_no" NVARCHAR(100) NULL,
    "status" NVARCHAR(20) DEFAULT 'unbilled',
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_exp_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id"),
    CONSTRAINT "FK_exp_coa" FOREIGN KEY ("category_id") REFERENCES "dbo"."chart_of_accounts"("id")
)
GO

CREATE TABLE "dbo"."expense_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "expense_id" INT NOT NULL,
    "description" NVARCHAR(MAX) NOT NULL,
    "amount" DECIMAL(18, 4) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_exp_item_main" FOREIGN KEY ("expense_id") REFERENCES "dbo"."expenses"("id") ON DELETE CASCADE
)
GO

-- ============================================================================
-- 6. MANUFACTURING (MRP)
-- ============================================================================

CREATE TABLE "dbo"."work_centers" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "code" NVARCHAR(20) UNIQUE NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "department_id" INT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_wc_dept" FOREIGN KEY ("department_id") REFERENCES "dbo"."departments"("id")
)
GO

CREATE TABLE "dbo"."production_lines" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "work_center_id" INT NOT NULL,
    "name" NVARCHAR(100) NOT NULL,
    "capacity_per_hour" DECIMAL(18, 4) DEFAULT 0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_pline_wc" FOREIGN KEY ("work_center_id") REFERENCES "dbo"."work_centers"("id")
)
GO

CREATE TABLE "dbo"."work_center_resources" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "work_center_id" INT NOT NULL,
    "resource_name" NVARCHAR(100) NOT NULL,
    "resource_type" NVARCHAR(50) DEFAULT 'human',
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_wcres_wc" FOREIGN KEY ("work_center_id") REFERENCES "dbo"."work_centers"("id")
)
GO

CREATE TABLE "dbo"."routing_plans" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."routing_operations" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "routing_plan_id" INT NOT NULL,
    "work_center_id" INT NOT NULL,
    "sequence" INT NOT NULL,
    "operation_name" NVARCHAR(100) NOT NULL,
    "setup_time_mins" DECIMAL(18, 2) DEFAULT 0,
    "cycle_time_mins" DECIMAL(18, 2) DEFAULT 0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_ro_plan" FOREIGN KEY ("routing_plan_id") REFERENCES "dbo"."routing_plans"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_ro_wc" FOREIGN KEY ("work_center_id") REFERENCES "dbo"."work_centers"("id")
)
GO

CREATE TABLE "dbo"."bill_of_materials" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "product_id" INT NOT NULL,
    "routing_plan_id" INT NULL,
    "bom_no" NVARCHAR(50) UNIQUE NOT NULL,
    "version" NVARCHAR(10) DEFAULT '1.0',
    "is_active_version" BIT DEFAULT 1,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_bom_product" FOREIGN KEY ("product_id") REFERENCES "dbo"."items"("id"),
    CONSTRAINT "FK_bom_routing" FOREIGN KEY ("routing_plan_id") REFERENCES "dbo"."routing_plans"("id")
)
GO

CREATE TABLE "dbo"."bom_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "bom_id" INT NOT NULL,
    "component_id" INT NOT NULL,
    "quantity" DECIMAL(18, 4) NOT NULL,
    "scrap_percentage" DECIMAL(5, 2) DEFAULT 0,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_bom_item_main" FOREIGN KEY ("bom_id") REFERENCES "dbo"."bill_of_materials"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_bom_item_link" FOREIGN KEY ("component_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."manufacturing_orders" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "mo_no" NVARCHAR(50) UNIQUE NOT NULL,
    "bom_id" INT NOT NULL,
    "warehouse_id" INT NOT NULL,
    "planned_start_date" DATETIME NULL,
    "planned_end_date" DATETIME NULL,
    "status" NVARCHAR(20) DEFAULT 'draft',
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_mo_bom" FOREIGN KEY ("bom_id") REFERENCES "dbo"."bill_of_materials"("id"),
    CONSTRAINT "FK_mo_warehouse" FOREIGN KEY ("warehouse_id") REFERENCES "dbo"."warehouses"("id")
)
GO

CREATE TABLE "dbo"."mo_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "mo_id" INT NOT NULL,
    "product_id" INT NOT NULL,
    "planned_quantity" DECIMAL(18, 4) NOT NULL,
    "produced_quantity" DECIMAL(18, 4) DEFAULT 0,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_mo_item_main" FOREIGN KEY ("mo_id") REFERENCES "dbo"."manufacturing_orders"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_mo_item_link" FOREIGN KEY ("product_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."work_orders" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "mo_id" INT NOT NULL,
    "routing_operation_id" INT NOT NULL,
    "work_center_id" INT NOT NULL,
    "status" NVARCHAR(20) DEFAULT 'pending',
    "started_at" DATETIME NULL,
    "completed_at" DATETIME NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_wo_mo" FOREIGN KEY ("mo_id") REFERENCES "dbo"."manufacturing_orders"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_wo_ro" FOREIGN KEY ("routing_operation_id") REFERENCES "dbo"."routing_operations"("id"),
    CONSTRAINT "FK_wo_wc" FOREIGN KEY ("work_center_id") REFERENCES "dbo"."work_centers"("id")
)
GO

CREATE TABLE "dbo"."work_order_logs" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "work_order_id" INT NOT NULL,
    "employee_id" INT NOT NULL,
    "start_time" DATETIME NOT NULL,
    "end_time" DATETIME NULL,
    "quantity_produced" DECIMAL(18, 4) DEFAULT 0,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_wolog_wo" FOREIGN KEY ("work_order_id") REFERENCES "dbo"."work_orders"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_wolog_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."material_requests" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "mo_id" INT NOT NULL,
    "request_date" DATE NOT NULL,
    "status" NVARCHAR(20) DEFAULT 'pending',
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_matreq_mo" FOREIGN KEY ("mo_id") REFERENCES "dbo"."manufacturing_orders"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."mo_material_issues" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "mo_id" INT NOT NULL,
    "item_id" INT NOT NULL,
    "warehouse_id" INT NOT NULL,
    "quantity_issued" DECIMAL(18, 4) NOT NULL,
    "issue_date" DATETIME DEFAULT GETDATE(),
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_miss_mo" FOREIGN KEY ("mo_id") REFERENCES "dbo"."manufacturing_orders"("id"),
    CONSTRAINT "FK_miss_item" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id"),
    CONSTRAINT "FK_miss_warehouse" FOREIGN KEY ("warehouse_id") REFERENCES "dbo"."warehouses"("id")
)
GO

CREATE TABLE "dbo"."mo_finished_goods_receipts" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "mo_id" INT NOT NULL,
    "item_id" INT NOT NULL,
    "warehouse_id" INT NOT NULL,
    "quantity_received" DECIMAL(18, 4) NOT NULL,
    "receipt_date" DATETIME DEFAULT GETDATE(),
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_fg_mo" FOREIGN KEY ("mo_id") REFERENCES "dbo"."manufacturing_orders"("id"),
    CONSTRAINT "FK_fg_item" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id"),
    CONSTRAINT "FK_fg_warehouse" FOREIGN KEY ("warehouse_id") REFERENCES "dbo"."warehouses"("id")
)
GO

CREATE TABLE "dbo"."scrap_management" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "mo_id" INT NULL,
    "work_order_id" INT NULL,
    "item_id" INT NOT NULL,
    "quantity" DECIMAL(18, 4) NOT NULL,
    "scrap_reason" NVARCHAR(MAX) NULL,
    "scrap_date" DATETIME DEFAULT GETDATE(),
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_scrap_mo" FOREIGN KEY ("mo_id") REFERENCES "dbo"."manufacturing_orders"("id"),
    CONSTRAINT "FK_scrap_wo" FOREIGN KEY ("work_order_id") REFERENCES "dbo"."work_orders"("id"),
    CONSTRAINT "FK_scrap_item" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."machine_types" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."machines" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "machine_type_id" INT NOT NULL,
    "work_center_id" INT NULL,
    "code" NVARCHAR(50) UNIQUE NOT NULL,
    "name" NVARCHAR(100) NOT NULL,
    "purchase_date" DATE NULL,
    "last_maintenance_date" DATE NULL,
    "status" NVARCHAR(20) DEFAULT 'available',
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_mach_type" FOREIGN KEY ("machine_type_id") REFERENCES "dbo"."machine_types"("id"),
    CONSTRAINT "FK_mach_wc" FOREIGN KEY ("work_center_id") REFERENCES "dbo"."work_centers"("id")
)
GO

CREATE TABLE "dbo"."maintenance_schedules" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "machine_id" INT NOT NULL,
    "schedule_date" DATE NOT NULL,
    "maintenance_type" NVARCHAR(50) DEFAULT 'preventive',
    "description" NVARCHAR(MAX) NULL,
    "status" NVARCHAR(20) DEFAULT 'scheduled',
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_maint_mach" FOREIGN KEY ("machine_id") REFERENCES "dbo"."machines"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."maintenance_logs" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "machine_id" INT NOT NULL,
    "performed_date" DATE NOT NULL,
    "performed_by" INT NULL,
    "description" NVARCHAR(MAX) NULL,
    "cost" DECIMAL(18, 4) DEFAULT 0,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_mlog_mach" FOREIGN KEY ("machine_id") REFERENCES "dbo"."machines"("id"),
    CONSTRAINT "FK_mlog_emp" FOREIGN KEY ("performed_by") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."quality_parameters" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "unit_of_measure" NVARCHAR(20) NULL,
    "min_value" DECIMAL(18, 4) NULL,
    "max_value" DECIMAL(18, 4) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."quality_inspections" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "mo_id" INT NULL,
    "item_id" INT NOT NULL,
    "inspector_id" INT NULL,
    "inspection_date" DATETIME DEFAULT GETDATE(),
    "status" NVARCHAR(20) DEFAULT 'passed',
    "notes" NVARCHAR(MAX) NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_qi_mo" FOREIGN KEY ("mo_id") REFERENCES "dbo"."manufacturing_orders"("id"),
    CONSTRAINT "FK_qi_item" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id"),
    CONSTRAINT "FK_qi_emp" FOREIGN KEY ("inspector_id") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."inspection_results" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "quality_inspection_id" INT NOT NULL,
    "quality_parameter_id" INT NOT NULL,
    "actual_value" DECIMAL(18, 4) NOT NULL,
    "is_passed" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_ir_qi" FOREIGN KEY ("quality_inspection_id") REFERENCES "dbo"."quality_inspections"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_ir_qp" FOREIGN KEY ("quality_parameter_id") REFERENCES "dbo"."quality_parameters"("id")
)
GO

CREATE TABLE "dbo"."downtime_reasons" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "reason_code" NVARCHAR(20) UNIQUE NOT NULL,
    "description" NVARCHAR(MAX) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."machine_downtime" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "machine_id" INT NOT NULL,
    "reason_id" INT NOT NULL,
    "start_time" DATETIME NOT NULL,
    "end_time" DATETIME NULL,
    "notes" NVARCHAR(MAX) NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_down_mach" FOREIGN KEY ("machine_id") REFERENCES "dbo"."machines"("id"),
    CONSTRAINT "FK_down_reason" FOREIGN KEY ("reason_id") REFERENCES "dbo"."downtime_reasons"("id")
)
GO

-- ============================================================================
-- 7. FLEET MANAGEMENT
-- ============================================================================

CREATE TABLE "dbo"."vehicle_types" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(50) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."vehicles" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "vehicle_type_id" INT NOT NULL,
    "plate_number" NVARCHAR(20) UNIQUE NOT NULL,
    "vin_number" NVARCHAR(50) UNIQUE NULL,
    "model" NVARCHAR(100) NOT NULL,
    "make" NVARCHAR(100) NOT NULL,
    "year" INT NULL,
    "color" NVARCHAR(30) NULL,
    "fuel_type" NVARCHAR(20) DEFAULT 'Diesel',
    "status" NVARCHAR(20) DEFAULT 'available',
    "odometer_reading" DECIMAL(18, 2) DEFAULT 0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_vehicle_type" FOREIGN KEY ("vehicle_type_id") REFERENCES "dbo"."vehicle_types"("id")
)
GO

CREATE TABLE "dbo"."vehicle_assignments" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "vehicle_id" INT NOT NULL,
    "employee_id" INT NOT NULL,
    "assigned_date" DATETIME NOT NULL,
    "returned_date" DATETIME NULL,
    "status" NVARCHAR(20) DEFAULT 'active',
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_vassign_vehicle" FOREIGN KEY ("vehicle_id") REFERENCES "dbo"."vehicles"("id"),
    CONSTRAINT "FK_vassign_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."fuel_logs" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "vehicle_id" INT NOT NULL,
    "employee_id" INT NOT NULL,
    "log_date" DATETIME NOT NULL,
    "odometer_reading" DECIMAL(18, 2) NOT NULL,
    "liters" DECIMAL(18, 4) NOT NULL,
    "total_amount" DECIMAL(18, 4) NOT NULL,
    "station_name" NVARCHAR(200) NULL,
    "reference_no" NVARCHAR(100) NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_fuel_vehicle" FOREIGN KEY ("vehicle_id") REFERENCES "dbo"."vehicles"("id"),
    CONSTRAINT "FK_fuel_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."vehicle_maintenance_types" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."vehicle_maintenance_logs" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "vehicle_id" INT NOT NULL,
    "maintenance_type_id" INT NOT NULL,
    "service_date" DATE NOT NULL,
    "odometer_reading" DECIMAL(18, 2) NULL,
    "service_vendor" NVARCHAR(200) NULL,
    "cost" DECIMAL(18, 4) DEFAULT 0,
    "description" NVARCHAR(MAX) NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_vmaint_vehicle" FOREIGN KEY ("vehicle_id") REFERENCES "dbo"."vehicles"("id"),
    CONSTRAINT "FK_vmaint_type" FOREIGN KEY ("maintenance_type_id") REFERENCES "dbo"."vehicle_maintenance_types"("id")
)
GO

CREATE TABLE "dbo"."vehicle_insurances" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "vehicle_id" INT NOT NULL,
    "provider" NVARCHAR(200) NOT NULL,
    "policy_number" NVARCHAR(100) UNIQUE NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "premium_amount" DECIMAL(18, 4) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_vins_vehicle" FOREIGN KEY ("vehicle_id") REFERENCES "dbo"."vehicles"("id")
)
GO

CREATE TABLE "dbo"."vehicle_documents" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "vehicle_id" INT NOT NULL,
    "document_type" NVARCHAR(50) NOT NULL,
    "document_number" NVARCHAR(100) NULL,
    "issue_date" DATE NULL,
    "expiry_date" DATE NULL,
    "file_path" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_vdoc_vehicle" FOREIGN KEY ("vehicle_id") REFERENCES "dbo"."vehicles"("id")
)
GO

CREATE TABLE "dbo"."vehicle_registrations" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "vehicle_id" INT NOT NULL,
    "registration_date" DATE NOT NULL,
    "expiry_date" DATE NOT NULL,
    "amount_paid" DECIMAL(18, 4) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_vreg_vehicle" FOREIGN KEY ("vehicle_id") REFERENCES "dbo"."vehicles"("id")
)
GO

CREATE TABLE "dbo"."vehicle_incidents" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "vehicle_id" INT NOT NULL,
    "employee_id" INT NOT NULL,
    "incident_date" DATETIME NOT NULL,
    "incident_type" NVARCHAR(50) DEFAULT 'accident',
    "description" NVARCHAR(MAX) NOT NULL,
    "location" NVARCHAR(MAX) NULL,
    "estimated_repair_cost" DECIMAL(18, 4) DEFAULT 0,
    "status" NVARCHAR(20) DEFAULT 'reported',
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_vinc_vehicle" FOREIGN KEY ("vehicle_id") REFERENCES "dbo"."vehicles"("id"),
    CONSTRAINT "FK_vinc_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."delivery_routes" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."delivery_stops" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "route_id" INT NOT NULL,
    "sequence" INT NOT NULL,
    "customer_id" INT NULL,
    "address_id" INT NULL,
    "estimated_arrival_time" DATETIME NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_stop_route" FOREIGN KEY ("route_id") REFERENCES "dbo"."delivery_routes"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_stop_cust" FOREIGN KEY ("customer_id") REFERENCES "dbo"."customers"("id"),
    CONSTRAINT "FK_stop_addr" FOREIGN KEY ("address_id") REFERENCES "dbo"."customer_addresses"("id")
)
GO

CREATE TABLE "dbo"."gps_logs" (
    "id" BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "vehicle_id" INT NOT NULL,
    "latitude" DECIMAL(9, 6) NOT NULL,
    "longitude" DECIMAL(9, 6) NOT NULL,
    "speed_kmh" DECIMAL(5, 2) DEFAULT 0,
    "log_time" DATETIME DEFAULT GETDATE(),
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_gps_vehicle" FOREIGN KEY ("vehicle_id") REFERENCES "dbo"."vehicles"("id")
)
GO

CREATE TABLE "dbo"."vehicle_tolls" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "vehicle_id" INT NOT NULL,
    "log_date" DATETIME NOT NULL,
    "toll_station" NVARCHAR(100) NULL,
    "amount" DECIMAL(18, 4) NOT NULL,
    "rfid_balance_after" DECIMAL(18, 4) NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_toll_vehicle" FOREIGN KEY ("vehicle_id") REFERENCES "dbo"."vehicles"("id")
)
GO

CREATE TABLE "dbo"."driver_licenses" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "employee_id" INT NOT NULL,
    "license_number" NVARCHAR(50) UNIQUE NOT NULL,
    "license_type" NVARCHAR(50) DEFAULT 'professional',
    "expiry_date" DATE NOT NULL,
    "restrictions" NVARCHAR(100) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_lic_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."driver_performance_logs" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "employee_id" INT NOT NULL,
    "evaluation_date" DATE NOT NULL,
    "safe_driving_score" INT DEFAULT 100,
    "fuel_efficiency_score" INT DEFAULT 100,
    "timeliness_score" INT DEFAULT 100,
    "notes" NVARCHAR(MAX) NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_perf_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id")
)
GO

-- ============================================================================
-- 8. HUMAN RESOURCES (Philippines compliance)
-- ============================================================================

CREATE TABLE "dbo"."departments" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "code" NVARCHAR(10) UNIQUE NOT NULL,
    "manager_id" INT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."positions" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "title" NVARCHAR(100) NOT NULL,
    "department_id" INT NULL,
    "salary_min" DECIMAL(18, 2) NULL,
    "salary_max" DECIMAL(18, 2) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_pos_dept" FOREIGN KEY ("department_id") REFERENCES "dbo"."departments"("id")
)
GO

CREATE TABLE "dbo"."employees" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "user_id" INT NULL,
    "employee_no" NVARCHAR(20) UNIQUE NOT NULL,
    "first_name" NVARCHAR(50) NOT NULL,
    "last_name" NVARCHAR(50) NOT NULL,
    "middle_name" NVARCHAR(50) NULL,
    "gender" NVARCHAR(10) NULL,
    "birth_date" DATE NULL,
    "hire_date" DATE NOT NULL,
    "position_id" INT NULL,
    "department_id" INT NULL,
    "status" NVARCHAR(20) DEFAULT 'probationary',
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_emp_user" FOREIGN KEY ("user_id") REFERENCES "dbo"."users"("id"),
    CONSTRAINT "FK_emp_pos" FOREIGN KEY ("position_id") REFERENCES "dbo"."positions"("id"),
    CONSTRAINT "FK_emp_dept" FOREIGN KEY ("department_id") REFERENCES "dbo"."departments"("id")
)
GO

ALTER TABLE "dbo"."departments" ADD CONSTRAINT "FK_dept_manager" FOREIGN KEY ("manager_id") REFERENCES "dbo"."employees"("id")
GO

CREATE TABLE "dbo"."employee_government_ids" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "employee_id" INT NOT NULL,
    "sss_no" NVARCHAR(20) NULL,
    "philhealth_no" NVARCHAR(20) NULL,
    "pagibig_no" NVARCHAR(20) NULL,
    "tin_no" NVARCHAR(20) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_gov_ids_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."employee_contracts" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "employee_id" INT NOT NULL,
    "contract_type" NVARCHAR(50) NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NULL,
    "basic_salary" DECIMAL(18, 4) NOT NULL,
    "regularization_date" DATE NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_contract_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."onboarding_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "title" NVARCHAR(100) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "is_mandatory" BIT DEFAULT 1,
    "category" NVARCHAR(50) DEFAULT 'document',
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."employee_documents" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "employee_id" INT NOT NULL,
    "document_type" NVARCHAR(100) NOT NULL,
    "document_no" NVARCHAR(50) NULL,
    "expiry_date" DATE NULL,
    "status" NVARCHAR(20) DEFAULT 'pending',
    "file_path" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_doc_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."employee_onboarding_status" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "employee_id" INT NOT NULL,
    "onboarding_item_id" INT NOT NULL,
    "is_completed" BIT DEFAULT 0,
    "completion_date" DATETIME NULL,
    "verified_by" INT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_obs_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_obs_item" FOREIGN KEY ("onboarding_item_id") REFERENCES "dbo"."onboarding_items"("id"),
    CONSTRAINT "FK_obs_verifier" FOREIGN KEY ("verified_by") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."employee_assets" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "employee_id" INT NOT NULL,
    "asset_name" NVARCHAR(100) NOT NULL,
    "asset_tag" NVARCHAR(50) UNIQUE NULL,
    "issued_date" DATE NOT NULL,
    "returned_date" DATE NULL,
    "condition" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_asset_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."holidays" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "holiday_date" DATE NOT NULL,
    "holiday_type" NVARCHAR(20) DEFAULT 'regular',
    "rate_multiplier" DECIMAL(5, 2) DEFAULT 1.0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."attendance_logs" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "employee_id" INT NOT NULL,
    "clock_in" DATETIME NOT NULL,
    "clock_out" DATETIME NULL,
    "work_date" DATE NOT NULL,
    "source" NVARCHAR(50) DEFAULT 'biometric',
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_attendance_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."overtime_requests" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "employee_id" INT NOT NULL,
    "ot_date" DATE NOT NULL,
    "hours" DECIMAL(5, 2) NOT NULL,
    "reason" NVARCHAR(MAX) NULL,
    "status" NVARCHAR(20) DEFAULT 'pending',
    "approved_by" INT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_ot_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id"),
    CONSTRAINT "FK_ot_approver" FOREIGN KEY ("approved_by") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."payroll_runs" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "period_start" DATE NOT NULL,
    "period_end" DATE NOT NULL,
    "payout_date" DATE NOT NULL,
    "status" NVARCHAR(20) DEFAULT 'draft',
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."payroll_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "payroll_run_id" INT NOT NULL,
    "employee_id" INT NOT NULL,
    "basic_pay" DECIMAL(18, 4) NOT NULL,
    "overtime_pay" DECIMAL(18, 4) DEFAULT 0,
    "sss_deduction" DECIMAL(18, 4) DEFAULT 0,
    "philhealth_deduction" DECIMAL(18, 4) DEFAULT 0,
    "pagibig_deduction" DECIMAL(18, 4) DEFAULT 0,
    "tax_withheld" DECIMAL(18, 4) DEFAULT 0,
    "thirteenth_month_accrual" DECIMAL(18, 4) DEFAULT 0,
    "net_pay" DECIMAL(18, 4) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_payroll_item_run" FOREIGN KEY ("payroll_run_id") REFERENCES "dbo"."payroll_runs"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_payroll_item_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."leave_types" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(50) NOT NULL,
    "days_per_year" INT NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."leave_requests" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "employee_id" INT NOT NULL,
    "leave_type_id" INT NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "reason" NVARCHAR(MAX) NULL,
    "status" NVARCHAR(20) DEFAULT 'pending',
    "approved_by" INT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_leave_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id"),
    CONSTRAINT "FK_leave_type" FOREIGN KEY ("leave_type_id") REFERENCES "dbo"."leave_types"("id"),
    CONSTRAINT "FK_leave_approver" FOREIGN KEY ("approved_by") REFERENCES "dbo"."employees"("id")
)
GO

-- ============================================================================
-- 9. CUSTOMER SUPPORT (Helpdesk & Knowledge Base)
-- ============================================================================

CREATE TABLE "dbo"."support_canned_responses" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "title" NVARCHAR(100) NOT NULL,
    "content" NVARCHAR(MAX) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."support_ticket_priorities" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(20) NOT NULL,
    "color_code" NVARCHAR(10) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."support_ticket_statuses" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(20) NOT NULL,
    "is_closed" BIT DEFAULT 0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."support_channels" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(20) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."support_agent_groups" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(50) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."support_agent_assignments" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "agent_id" INT NOT NULL,
    "group_id" INT NOT NULL,
    "is_leader" BIT DEFAULT 0,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_saga_agent" FOREIGN KEY ("agent_id") REFERENCES "dbo"."employees"("id"),
    CONSTRAINT "FK_saga_group" FOREIGN KEY ("group_id") REFERENCES "dbo"."support_agent_groups"("id")
)
GO

CREATE TABLE "dbo"."support_tickets" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "ticket_no" NVARCHAR(20) UNIQUE NOT NULL,
    "customer_id" INT NOT NULL,
    "subject" NVARCHAR(200) NOT NULL,
    "description" NVARCHAR(MAX) NOT NULL,
    "priority_id" INT NULL,
    "status_id" INT NULL,
    "channel_id" INT NULL,
    "assigned_agent_id" INT NULL,
    "assigned_group_id" INT NULL,
    "first_responded_at" DATETIME NULL,
    "solved_at" DATETIME NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_st_cust" FOREIGN KEY ("customer_id") REFERENCES "dbo"."customers"("id"),
    CONSTRAINT "FK_st_priority" FOREIGN KEY ("priority_id") REFERENCES "dbo"."support_ticket_priorities"("id"),
    CONSTRAINT "FK_st_status" FOREIGN KEY ("status_id") REFERENCES "dbo"."support_ticket_statuses"("id"),
    CONSTRAINT "FK_st_channel" FOREIGN KEY ("channel_id") REFERENCES "dbo"."support_channels"("id"),
    CONSTRAINT "FK_st_agent" FOREIGN KEY ("assigned_agent_id") REFERENCES "dbo"."employees"("id"),
    CONSTRAINT "FK_st_group" FOREIGN KEY ("assigned_group_id") REFERENCES "dbo"."support_agent_groups"("id")
)
GO

CREATE TABLE "dbo"."support_ticket_tags" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "ticket_id" INT NOT NULL,
    "tag_name" NVARCHAR(50) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_stt_ticket" FOREIGN KEY ("ticket_id") REFERENCES "dbo"."support_tickets"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."support_ticket_comments" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "ticket_id" INT NOT NULL,
    "author_user_id" INT NULL,
    "author_customer_id" INT NULL,
    "comment_body" NVARCHAR(MAX) NOT NULL,
    "is_internal" BIT DEFAULT 0,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_stc_ticket" FOREIGN KEY ("ticket_id") REFERENCES "dbo"."support_tickets"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_stc_user" FOREIGN KEY ("author_user_id") REFERENCES "dbo"."users"("id"),
    CONSTRAINT "FK_stc_cust" FOREIGN KEY ("author_customer_id") REFERENCES "dbo"."customers"("id")
)
GO

CREATE TABLE "dbo"."support_ticket_attachments" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "comment_id" INT NOT NULL,
    "file_name" NVARCHAR(255) NOT NULL,
    "file_path" NVARCHAR(MAX) NOT NULL,
    "file_size" INT NULL,
    "content_type" NVARCHAR(100) NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_sta_comment" FOREIGN KEY ("comment_id") REFERENCES "dbo"."support_ticket_comments"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."support_sla_policies" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."support_sla_targets" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "policy_id" INT NOT NULL,
    "priority_id" INT NOT NULL,
    "target_type" NVARCHAR(50) NOT NULL,
    "target_hours" DECIMAL(10, 2) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_sslat_policy" FOREIGN KEY ("policy_id") REFERENCES "dbo"."support_sla_policies"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_sslat_priority" FOREIGN KEY ("priority_id") REFERENCES "dbo"."support_ticket_priorities"("id")
)
GO

CREATE TABLE "dbo"."support_ticket_slas" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "ticket_id" INT NOT NULL,
    "target_type" NVARCHAR(50) NOT NULL,
    "deadline" DATETIME NOT NULL,
    "fulfillment_date" DATETIME NULL,
    "is_breached" BIT DEFAULT 0,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_stsla_ticket" FOREIGN KEY ("ticket_id") REFERENCES "dbo"."support_tickets"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."support_satisfaction_surveys" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "ticket_id" INT UNIQUE NOT NULL,
    "score" INT NOT NULL,
    "comment" NVARCHAR(MAX) NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_sat_ticket" FOREIGN KEY ("ticket_id") REFERENCES "dbo"."support_tickets"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."support_kb_categories" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "parent_id" INT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_kbcat_parent" FOREIGN KEY ("parent_id") REFERENCES "dbo"."support_kb_categories"("id")
)
GO

CREATE TABLE "dbo"."support_kb_articles" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "category_id" INT NOT NULL,
    "title" NVARCHAR(200) NOT NULL,
    "content" NVARCHAR(MAX) NOT NULL,
    "author_id" INT NULL,
    "view_count" INT DEFAULT 0,
    "status" NVARCHAR(20) DEFAULT 'published',
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_kba_cat" FOREIGN KEY ("category_id") REFERENCES "dbo"."support_kb_categories"("id"),
    CONSTRAINT "FK_kba_author" FOREIGN KEY ("author_id") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."support_kb_article_votes" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "article_id" INT NOT NULL,
    "is_upvote" BIT DEFAULT 1,
    "customer_id" INT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_kbv_art" FOREIGN KEY ("article_id") REFERENCES "dbo"."support_kb_articles"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_kbv_cust" FOREIGN KEY ("customer_id") REFERENCES "dbo"."customers"("id")
)
GO

-- ============================================================================
-- 10. PROJECT MANAGEMENT
-- ============================================================================

CREATE TABLE "dbo"."project_types" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(50) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."project_statuses" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(50) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."projects" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "project_no" NVARCHAR(20) UNIQUE NOT NULL,
    "name" NVARCHAR(200) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "project_type_id" INT NULL,
    "status_id" INT NULL,
    "customer_id" INT NULL,
    "manager_id" INT NULL,
    "start_date" DATE NULL,
    "end_date" DATE NULL,
    "budget_allocated" DECIMAL(18, 4) DEFAULT 0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_proj_type" FOREIGN KEY ("project_type_id") REFERENCES "dbo"."project_types"("id"),
    CONSTRAINT "FK_proj_status" FOREIGN KEY ("status_id") REFERENCES "dbo"."project_statuses"("id"),
    CONSTRAINT "FK_proj_cust" FOREIGN KEY ("customer_id") REFERENCES "dbo"."customers"("id"),
    CONSTRAINT "FK_proj_mgr" FOREIGN KEY ("manager_id") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."project_budgets" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "project_id" INT NOT NULL,
    "category" NVARCHAR(50) NOT NULL,
    "estimated_amount" DECIMAL(18, 4) NOT NULL,
    "actual_amount" DECIMAL(18, 4) DEFAULT 0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_pbud_proj" FOREIGN KEY ("project_id") REFERENCES "dbo"."projects"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."project_member_roles" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "role_name" NVARCHAR(50) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."project_members" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "project_id" INT NOT NULL,
    "employee_id" INT NOT NULL,
    "role_id" INT NULL,
    "joined_at" DATETIME DEFAULT GETDATE(),
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_pmem_proj" FOREIGN KEY ("project_id") REFERENCES "dbo"."projects"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_pmem_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id"),
    CONSTRAINT "FK_pmem_role" FOREIGN KEY ("role_id") REFERENCES "dbo"."project_member_roles"("id")
)
GO

CREATE TABLE "dbo"."project_milestones" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "project_id" INT NOT NULL,
    "name" NVARCHAR(100) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "due_date" DATE NOT NULL,
    "completed_at" DATETIME NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_mile_proj" FOREIGN KEY ("project_id") REFERENCES "dbo"."projects"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."project_task_priorities" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(20) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."project_task_types" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(50) NOT NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."project_tasks" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "project_id" INT NOT NULL,
    "milestone_id" INT NULL,
    "parent_task_id" INT NULL,
    "name" NVARCHAR(200) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "status" NVARCHAR(20) DEFAULT 'todo',
    "priority_id" INT NULL,
    "task_type_id" INT NULL,
    "estimated_hours" DECIMAL(10, 2) DEFAULT 0,
    "actual_hours" DECIMAL(10, 2) DEFAULT 0,
    "start_date" DATE NULL,
    "due_date" DATE NULL,
    "completed_at" DATETIME NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_ptask_proj" FOREIGN KEY ("project_id") REFERENCES "dbo"."projects"("id"),
    CONSTRAINT "FK_ptask_mile" FOREIGN KEY ("milestone_id") REFERENCES "dbo"."project_milestones"("id"),
    CONSTRAINT "FK_ptask_parent" FOREIGN KEY ("parent_task_id") REFERENCES "dbo"."project_tasks"("id"),
    CONSTRAINT "FK_ptask_priority" FOREIGN KEY ("priority_id") REFERENCES "dbo"."project_task_priorities"("id"),
    CONSTRAINT "FK_ptask_type" FOREIGN KEY ("task_type_id") REFERENCES "dbo"."project_task_types"("id")
)
GO

CREATE TABLE "dbo"."project_task_assignees" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "task_id" INT NOT NULL,
    "employee_id" INT NOT NULL,
    "assigned_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_tass_task" FOREIGN KEY ("task_id") REFERENCES "dbo"."project_tasks"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_tass_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."project_task_comments" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "task_id" INT NOT NULL,
    "user_id" INT NOT NULL,
    "comment_body" NVARCHAR(MAX) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_tcom_task" FOREIGN KEY ("task_id") REFERENCES "dbo"."project_tasks"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_tcom_user" FOREIGN KEY ("user_id") REFERENCES "dbo"."users"("id")
)
GO

CREATE TABLE "dbo"."project_task_attachments" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "task_id" INT NOT NULL,
    "file_name" NVARCHAR(255) NOT NULL,
    "file_path" NVARCHAR(MAX) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_tatt_task" FOREIGN KEY ("task_id") REFERENCES "dbo"."project_tasks"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."project_task_dependencies" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "task_id" INT NOT NULL,
    "depends_on_task_id" INT NOT NULL,
    "dependency_type" NVARCHAR(20) DEFAULT 'finish_to_start',
    "created_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_tdep_task" FOREIGN KEY ("task_id") REFERENCES "dbo"."project_tasks"("id"),
    CONSTRAINT "FK_tdep_dep" FOREIGN KEY ("depends_on_task_id") REFERENCES "dbo"."project_tasks"("id")
)
GO

CREATE TABLE "dbo"."project_timesheets" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "employee_id" INT NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "status" NVARCHAR(20) DEFAULT 'draft',
    "total_hours" DECIMAL(10, 2) DEFAULT 0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_time_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."project_timesheet_entries" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "timesheet_id" INT NOT NULL,
    "project_id" INT NOT NULL,
    "task_id" INT NULL,
    "entry_date" DATE NOT NULL,
    "hours" DECIMAL(5, 2) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "is_billable" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_tline_main" FOREIGN KEY ("timesheet_id") REFERENCES "dbo"."project_timesheets"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_tline_proj" FOREIGN KEY ("project_id") REFERENCES "dbo"."projects"("id"),
    CONSTRAINT "FK_tline_task" FOREIGN KEY ("task_id") REFERENCES "dbo"."project_tasks"("id")
)
GO

-- ============================================================================
-- 11. PROCUREMENT & SUPPLIERS
-- ============================================================================

CREATE TABLE "dbo"."suppliers" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(200) NOT NULL,
    "tax_id" NVARCHAR(50) NULL,
    "payment_terms" NVARCHAR(50) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."supplier_contacts" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "supplier_id" INT NOT NULL,
    "name" NVARCHAR(100) NOT NULL,
    "email" NVARCHAR(100) NULL,
    "phone" NVARCHAR(20) NULL,
    "is_primary" BIT DEFAULT 0,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_contact_supplier" FOREIGN KEY ("supplier_id") REFERENCES "dbo"."suppliers"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."purchase_orders" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "po_no" NVARCHAR(20) UNIQUE NOT NULL,
    "supplier_id" INT NOT NULL,
    "order_date" DATE NOT NULL,
    "total_amount" DECIMAL(18, 4) DEFAULT 0,
    "status" NVARCHAR(20) DEFAULT 'draft',
    "notes" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_po_supplier" FOREIGN KEY ("supplier_id") REFERENCES "dbo"."suppliers"("id")
)
GO

CREATE TABLE "dbo"."purchase_order_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "po_id" INT NOT NULL,
    "product_name" NVARCHAR(200) NOT NULL,
    "quantity" DECIMAL(18, 2) NOT NULL,
    "unit_price" DECIMAL(18, 4) NOT NULL,
    "total_price" DECIMAL(18, 4) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_poi_po" FOREIGN KEY ("po_id") REFERENCES "dbo"."purchase_orders"("id") ON DELETE CASCADE
)
GO

-- ============================================================================
-- 12. FIXED ASSET MANAGEMENT
-- ============================================================================

CREATE TABLE "dbo"."asset_categories" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "code" NVARCHAR(10) UNIQUE NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "depreciation_rate" DECIMAL(5, 2) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."asset_depreciation_methods" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(50) NOT NULL,
    "code" NVARCHAR(10) UNIQUE NOT NULL,
    "formula" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."fixed_assets" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "asset_category_id" INT NOT NULL,
    "asset_no" NVARCHAR(20) UNIQUE NOT NULL,
    "name" NVARCHAR(200) NOT NULL,
    "purchase_date" DATE NOT NULL,
    "purchase_value" DECIMAL(18, 4) NOT NULL,
    "salvage_value" DECIMAL(18, 4) DEFAULT 0,
    "useful_life_years" INT NULL,
    "depreciation_method_id" INT NULL,
    "current_value" DECIMAL(18, 4) NULL,
    "status" NVARCHAR(20) DEFAULT 'active',
    "location" NVARCHAR(200) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_asset_cat" FOREIGN KEY ("asset_category_id") REFERENCES "dbo"."asset_categories"("id"),
    CONSTRAINT "FK_asset_depr" FOREIGN KEY ("depreciation_method_id") REFERENCES "dbo"."asset_depreciation_methods"("id")
)
GO

CREATE TABLE "dbo"."asset_depreciation_logs" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "asset_id" INT NOT NULL,
    "fiscal_year_id" INT NOT NULL,
    "depreciation_date" DATE NOT NULL,
    "amount" DECIMAL(18, 4) NOT NULL,
    "accumulated_depreciation" DECIMAL(18, 4) NOT NULL,
    "book_value_after" DECIMAL(18, 4) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_adepr_asset" FOREIGN KEY ("asset_id") REFERENCES "dbo"."fixed_assets"("id"),
    CONSTRAINT "FK_adepr_fy" FOREIGN KEY ("fiscal_year_id") REFERENCES "dbo"."fiscal_years"("id")
)
GO

CREATE TABLE "dbo"."asset_disposals" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "asset_id" INT NOT NULL,
    "disposal_date" DATE NOT NULL,
    "disposal_type" NVARCHAR(20) DEFAULT 'sale',
    "sale_amount" DECIMAL(18, 4) DEFAULT 0,
    "gain_loss" DECIMAL(18, 4) DEFAULT 0,
    "notes" NVARCHAR(MAX) NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_disp_asset" FOREIGN KEY ("asset_id") REFERENCES "dbo"."fixed_assets"("id")
)
GO

CREATE TABLE "dbo"."asset_transfers" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "asset_id" INT NOT NULL,
    "from_location" NVARCHAR(200) NULL,
    "to_location" NVARCHAR(200) NULL,
    "transfer_date" DATE NOT NULL,
    "transferred_by" INT NULL,
    "notes" NVARCHAR(MAX) NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_atrans_asset" FOREIGN KEY ("asset_id") REFERENCES "dbo"."fixed_assets"("id"),
    CONSTRAINT "FK_atrans_emp" FOREIGN KEY ("transferred_by") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."asset_maintenance_contracts" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "asset_id" INT NOT NULL,
    "vendor_name" NVARCHAR(200) NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "contract_value" DECIMAL(18, 4) NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_amc_asset" FOREIGN KEY ("asset_id") REFERENCES "dbo"."fixed_assets"("id")
)
GO

CREATE TABLE "dbo"."asset_custodians" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "asset_id" INT NOT NULL,
    "employee_id" INT NOT NULL,
    "assigned_date" DATE NOT NULL,
    "returned_date" DATE NULL,
    "status" NVARCHAR(20) DEFAULT 'active',
    "created_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_cust_asset" FOREIGN KEY ("asset_id") REFERENCES "dbo"."fixed_assets"("id"),
    CONSTRAINT "FK_cust_emp_link" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id")
)
GO

-- ============================================================================
-- 13. MARKETING & CRM (LEAD MANAGEMENT)
-- ============================================================================

CREATE TABLE "dbo"."marketing_campaigns" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(200) NOT NULL,
    "type" NVARCHAR(50) NULL,
    "status" NVARCHAR(20) DEFAULT 'planning',
    "budget" DECIMAL(18, 4) DEFAULT 0,
    "actual_cost" DECIMAL(18, 4) DEFAULT 0,
    "start_date" DATE NULL,
    "end_date" DATE NULL,
    "active_flag" BIT DEFAULT 1,
    "created_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."crm_lead_sources" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "active_flag" BIT DEFAULT 1
)
GO

CREATE TABLE "dbo"."crm_leads" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "first_name" NVARCHAR(100) NOT NULL,
    "last_name" NVARCHAR(100) NOT NULL,
    "company_name" NVARCHAR(200) NULL,
    "email" NVARCHAR(100) NULL,
    "phone" NVARCHAR(20) NULL,
    "lead_source_id" INT NULL,
    "campaign_id" INT NULL,
    "status" NVARCHAR(20) DEFAULT 'new',
    "assigned_to" INT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    "updated_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_lead_source" FOREIGN KEY ("lead_source_id") REFERENCES "dbo"."crm_lead_sources"("id"),
    CONSTRAINT "FK_lead_camp" FOREIGN KEY ("campaign_id") REFERENCES "dbo"."marketing_campaigns"("id"),
    CONSTRAINT "FK_lead_user" FOREIGN KEY ("assigned_to") REFERENCES "dbo"."users"("id")
)
GO

CREATE TABLE "dbo"."crm_opportunity_stages" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(50) NOT NULL,
    "probability" INT DEFAULT 0,
    "active_flag" BIT DEFAULT 1
)
GO

CREATE TABLE "dbo"."crm_opportunities" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "lead_id" INT NULL,
    "customer_id" INT NULL,
    "name" NVARCHAR(200) NOT NULL,
    "stage_id" INT NOT NULL,
    "amount" DECIMAL(18, 4) DEFAULT 0,
    "expected_closing_date" DATE NULL,
    "assigned_to" INT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_opp_lead" FOREIGN KEY ("lead_id") REFERENCES "dbo"."crm_leads"("id"),
    CONSTRAINT "FK_opp_cust" FOREIGN KEY ("customer_id") REFERENCES "dbo"."customers"("id"),
    CONSTRAINT "FK_opp_stage" FOREIGN KEY ("stage_id") REFERENCES "dbo"."crm_opportunity_stages"("id"),
    CONSTRAINT "FK_opp_user" FOREIGN KEY ("assigned_to") REFERENCES "dbo"."users"("id")
)
GO

CREATE TABLE "dbo"."crm_sales_quotations" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "opportunity_id" INT NULL,
    "customer_id" INT NOT NULL,
    "quotation_no" NVARCHAR(20) UNIQUE NOT NULL,
    "quotation_date" DATE NOT NULL,
    "expiry_date" DATE NULL,
    "total_amount" DECIMAL(18, 4) NOT NULL,
    "status" NVARCHAR(20) DEFAULT 'draft',
    "created_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_quot_opp" FOREIGN KEY ("opportunity_id") REFERENCES "dbo"."crm_opportunities"("id"),
    CONSTRAINT "FK_quot_cust" FOREIGN KEY ("customer_id") REFERENCES "dbo"."customers"("id")
)
GO

CREATE TABLE "dbo"."crm_quotation_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "quotation_id" INT NOT NULL,
    "item_id" INT NOT NULL,
    "quantity" DECIMAL(18, 4) NOT NULL,
    "rate" DECIMAL(18, 4) NOT NULL,
    "total_amount" DECIMAL(18, 4) NOT NULL,
    CONSTRAINT "FK_qitem_main" FOREIGN KEY ("quotation_id") REFERENCES "dbo"."crm_sales_quotations"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_qitem_link" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."crm_competitors" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(200) NOT NULL,
    "website" NVARCHAR(MAX) NULL,
    "strengths" NVARCHAR(MAX) NULL,
    "weaknesses" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1
)
GO

CREATE TABLE "dbo"."crm_contact_interactions" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "customer_id" INT NULL,
    "lead_id" INT NULL,
    "interaction_date" DATETIME NOT NULL,
    "interaction_type" NVARCHAR(50) DEFAULT 'call',
    "subject" NVARCHAR(200) NULL,
    "notes" NVARCHAR(MAX) NULL,
    "performed_by" INT NULL,
    CONSTRAINT "FK_int_cust" FOREIGN KEY ("customer_id") REFERENCES "dbo"."customers"("id"),
    CONSTRAINT "FK_int_lead" FOREIGN KEY ("lead_id") REFERENCES "dbo"."crm_leads"("id"),
    CONSTRAINT "FK_int_user" FOREIGN KEY ("performed_by") REFERENCES "dbo"."users"("id")
)
GO

CREATE TABLE "dbo"."crm_sales_territories" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "region" NVARCHAR(100) NULL,
    "manager_id" INT NULL,
    "active_flag" BIT DEFAULT 1,
    CONSTRAINT "FK_terr_mgr" FOREIGN KEY ("manager_id") REFERENCES "dbo"."employees"("id")
)
GO

-- ============================================================================
-- 14. RECRUITMENT & TALENT MANAGEMENT
-- ============================================================================

CREATE TABLE "dbo"."hr_job_postings" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "position_id" INT NOT NULL,
    "title" NVARCHAR(200) NOT NULL,
    "description" NVARCHAR(MAX) NOT NULL,
    "status" NVARCHAR(20) DEFAULT 'open',
    "posted_date" DATE DEFAULT GETDATE(),
    "expiry_date" DATE NULL,
    CONSTRAINT "FK_job_pos" FOREIGN KEY ("position_id") REFERENCES "dbo"."positions"("id")
)
GO

CREATE TABLE "dbo"."hr_job_applicants" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "first_name" NVARCHAR(100) NOT NULL,
    "last_name" NVARCHAR(100) NOT NULL,
    "email" NVARCHAR(100) NOT NULL,
    "phone" NVARCHAR(20) NULL,
    "resume_path" NVARCHAR(MAX) NULL,
    "created_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."hr_applicant_statuses" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(50) NOT NULL,
    "is_final" BIT DEFAULT 0,
    "active_flag" BIT DEFAULT 1
)
GO

CREATE TABLE "dbo"."hr_interviews" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "posting_id" INT NOT NULL,
    "applicant_id" INT NOT NULL,
    "interview_date" DATETIME NOT NULL,
    "interview_type" NVARCHAR(50) DEFAULT 'technical',
    "status" NVARCHAR(20) DEFAULT 'scheduled',
    CONSTRAINT "FK_intrv_job" FOREIGN KEY ("posting_id") REFERENCES "dbo"."hr_job_postings"("id"),
    CONSTRAINT "FK_intrv_app" FOREIGN KEY ("applicant_id") REFERENCES "dbo"."hr_job_applicants"("id")
)
GO

CREATE TABLE "dbo"."hr_interview_results" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "interview_id" INT NOT NULL,
    "interviewer_id" INT NOT NULL,
    "score" INT NULL,
    "comments" NVARCHAR(MAX) NULL,
    "recommendation" NVARCHAR(50) NULL,
    CONSTRAINT "FK_ires_int" FOREIGN KEY ("interview_id") REFERENCES "dbo"."hr_interviews"("id"),
    CONSTRAINT "FK_ires_emp" FOREIGN KEY ("interviewer_id") REFERENCES "dbo"."employees"("id")
)
GO

CREATE TABLE "dbo"."hr_onboarding_checklists" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "active_flag" BIT DEFAULT 1
)
GO

CREATE TABLE "dbo"."hr_training_courses" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(200) NOT NULL,
    "description" NVARCHAR(MAX) NULL,
    "duration_hours" INT NULL,
    "active_flag" BIT DEFAULT 1
)
GO

CREATE TABLE "dbo"."hr_employee_certifications" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "employee_id" INT NOT NULL,
    "certification_name" NVARCHAR(200) NOT NULL,
    "issuing_body" NVARCHAR(200) NULL,
    "issue_date" DATE NULL,
    "expiry_date" DATE NULL,
    CONSTRAINT "FK_cert_emp" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."hr_performance_reviews" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "employee_id" INT NOT NULL,
    "reviewer_id" INT NOT NULL,
    "review_date" DATE NOT NULL,
    "period_start" DATE NOT NULL,
    "period_end" DATE NOT NULL,
    "rating" DECIMAL(3, 2) NULL,
    "comments" NVARCHAR(MAX) NULL,
    CONSTRAINT "FK_perf_emp_rev" FOREIGN KEY ("employee_id") REFERENCES "dbo"."employees"("id"),
    CONSTRAINT "FK_perf_rev_user" FOREIGN KEY ("reviewer_id") REFERENCES "dbo"."employees"("id")
)
GO

-- ============================================================================
-- 15. PROCUREMENT (RFQ & CONTRACTS)
-- ============================================================================

CREATE TABLE "dbo"."procurement_rfqs" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "rfq_no" NVARCHAR(20) UNIQUE NOT NULL,
    "subject" NVARCHAR(200) NOT NULL,
    "status" NVARCHAR(20) DEFAULT 'draft',
    "expiry_date" DATE NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."procurement_rfq_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "rfq_id" INT NOT NULL,
    "item_id" INT NOT NULL,
    "quantity" DECIMAL(18, 4) NOT NULL,
    "notes" NVARCHAR(MAX) NULL,
    CONSTRAINT "FK_rfqi_main" FOREIGN KEY ("rfq_id") REFERENCES "dbo"."procurement_rfqs"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_rfqi_link" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."procurement_vendor_responses" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "rfq_id" INT NOT NULL,
    "supplier_id" INT NOT NULL,
    "response_date" DATE NOT NULL,
    "unit_price" DECIMAL(18, 4) NOT NULL,
    "delivery_lead_time_days" INT NULL,
    "notes" NVARCHAR(MAX) NULL,
    CONSTRAINT "FK_vresp_rfq" FOREIGN KEY ("rfq_id") REFERENCES "dbo"."procurement_rfqs"("id"),
    CONSTRAINT "FK_vresp_sup" FOREIGN KEY ("supplier_id") REFERENCES "dbo"."suppliers"("id")
)
GO

CREATE TABLE "dbo"."procurement_bid_evaluation" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "rfq_id" INT NOT NULL,
    "winner_supplier_id" INT NOT NULL,
    "evaluation_score" INT NULL,
    "approved_by" INT NULL,
    "comments" NVARCHAR(MAX) NULL,
    CONSTRAINT "FK_bid_rfq" FOREIGN KEY ("rfq_id") REFERENCES "dbo"."procurement_rfqs"("id"),
    CONSTRAINT "FK_bid_sup" FOREIGN KEY ("winner_supplier_id") REFERENCES "dbo"."suppliers"("id")
)
GO

CREATE TABLE "dbo"."purchase_contracts" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "supplier_id" INT NOT NULL,
    "contract_no" NVARCHAR(50) UNIQUE NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "total_value" DECIMAL(18, 4) NULL,
    "status" NVARCHAR(20) DEFAULT 'active',
    "active_flag" BIT DEFAULT 1,
    CONSTRAINT "FK_pcon_sup" FOREIGN KEY ("supplier_id") REFERENCES "dbo"."suppliers"("id")
)
GO

CREATE TABLE "dbo"."purchase_contract_items" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "contract_id" INT NOT NULL,
    "item_id" INT NOT NULL,
    "negotiated_price" DECIMAL(18, 4) NOT NULL,
    "min_order_quantity" DECIMAL(18, 4) DEFAULT 0,
    CONSTRAINT "FK_pci_main" FOREIGN KEY ("contract_id") REFERENCES "dbo"."purchase_contracts"("id") ON DELETE CASCADE,
    CONSTRAINT "FK_pci_link" FOREIGN KEY ("item_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."supplier_evaluation_criteria" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "criterion_name" NVARCHAR(100) NOT NULL,
    "weight" DECIMAL(5, 2) NOT NULL,
    "active_flag" BIT DEFAULT 1
)
GO

CREATE TABLE "dbo"."supplier_audit_logs" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "supplier_id" INT NOT NULL,
    "audit_date" DATE NOT NULL,
    "auditor_id" INT NULL,
    "score" INT NULL,
    "summary" NVARCHAR(MAX) NULL,
    CONSTRAINT "FK_saudit_sup" FOREIGN KEY ("supplier_id") REFERENCES "dbo"."suppliers"("id") ON DELETE CASCADE
)
GO

-- ============================================================================
-- 16. QUALITY CONTROL & COMPLIANCE
-- ============================================================================

CREATE TABLE "dbo"."quality_control_plans" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(200) NOT NULL,
    "product_id" INT NULL,
    "active_flag" BIT DEFAULT 1,
    CONSTRAINT "FK_qcp_product" FOREIGN KEY ("product_id") REFERENCES "dbo"."items"("id")
)
GO

CREATE TABLE "dbo"."quality_test_groups" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "active_flag" BIT DEFAULT 1
)
GO

CREATE TABLE "dbo"."quality_test_definitions" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "group_id" INT NOT NULL,
    "name" NVARCHAR(100) NOT NULL,
    "min_limit" DECIMAL(18, 4) NULL,
    "max_limit" DECIMAL(18, 4) NULL,
    "active_flag" BIT DEFAULT 1,
    CONSTRAINT "FK_qtest_group" FOREIGN KEY ("group_id") REFERENCES "dbo"."quality_test_groups"("id")
)
GO

CREATE TABLE "dbo"."non_conformance_reports" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "inspection_id" INT NULL,
    "report_no" NVARCHAR(20) UNIQUE NOT NULL,
    "defect_description" NVARCHAR(MAX) NOT NULL,
    "severity" NVARCHAR(20) DEFAULT 'medium',
    "status" NVARCHAR(20) DEFAULT 'open',
    "created_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_ncr_qi" FOREIGN KEY ("inspection_id") REFERENCES "dbo"."quality_inspections"("id")
)
GO

CREATE TABLE "dbo"."corrective_actions" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "ncr_id" INT NOT NULL,
    "action_plan" NVARCHAR(MAX) NOT NULL,
    "assigned_to" INT NULL,
    "deadline" DATE NULL,
    "completed_at" DATETIME NULL,
    CONSTRAINT "FK_ca_ncr" FOREIGN KEY ("ncr_id") REFERENCES "dbo"."non_conformance_reports"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."compliance_regulations" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(200) NOT NULL,
    "governing_body" NVARCHAR(100) NULL,
    "effective_date" DATE NULL,
    "active_flag" BIT DEFAULT 1
)
GO

CREATE TABLE "dbo"."compliance_audit_logs" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "regulation_id" INT NOT NULL,
    "audit_date" DATE NOT NULL,
    "findings" NVARCHAR(MAX) NULL,
    "is_compliant" BIT DEFAULT 1,
    CONSTRAINT "FK_clog_reg" FOREIGN KEY ("regulation_id") REFERENCES "dbo"."compliance_regulations"("id")
)
GO

-- ============================================================================
-- 17. BUDGETING & FINANCIAL ENTITIES
-- ============================================================================

CREATE TABLE "dbo"."budget_periods" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(50) NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "active_flag" BIT DEFAULT 1
)
GO

CREATE TABLE "dbo"."cost_centers" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "code" NVARCHAR(10) UNIQUE NOT NULL,
    "department_id" INT NULL,
    "active_flag" BIT DEFAULT 1,
    CONSTRAINT "FK_cc_dept" FOREIGN KEY ("department_id") REFERENCES "dbo"."departments"("id")
)
GO

CREATE TABLE "dbo"."budget_allocations" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "budget_period_id" INT NOT NULL,
    "cost_center_id" INT NOT NULL,
    "account_id" INT NOT NULL,
    "planned_amount" DECIMAL(18, 4) NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_ball_period" FOREIGN KEY ("budget_period_id") REFERENCES "dbo"."budget_periods"("id"),
    CONSTRAINT "FK_ball_cc" FOREIGN KEY ("cost_center_id") REFERENCES "dbo"."cost_centers"("id"),
    CONSTRAINT "FK_ball_coa" FOREIGN KEY ("account_id") REFERENCES "dbo"."chart_of_accounts"("id")
)
GO

CREATE TABLE "dbo"."budget_variances" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "allocation_id" INT NOT NULL,
    "actual_amount" DECIMAL(18, 4) NOT NULL,
    "variance_amount" DECIMAL(18, 4) NOT NULL,
    "notes" NVARCHAR(MAX) NULL,
    CONSTRAINT "FK_bvar_ball" FOREIGN KEY ("allocation_id") REFERENCES "dbo"."budget_allocations"("id") ON DELETE CASCADE
)
GO

CREATE TABLE "dbo"."finance_tax_rules" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "rate" DECIMAL(5, 2) NOT NULL,
    "is_compound" BIT DEFAULT 0,
    "active_flag" BIT DEFAULT 1
)
GO

CREATE TABLE "dbo"."finance_currency_rates" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "currency_code" NVARCHAR(3) NOT NULL,
    "rate_to_base" DECIMAL(18, 8) NOT NULL,
    "effective_date" DATE NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."sys_entities" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(200) NOT NULL,
    "tax_id" NVARCHAR(50) NULL,
    "base_currency" NVARCHAR(3) DEFAULT 'PHP',
    "active_flag" BIT DEFAULT 1
)
GO

CREATE TABLE "dbo"."sys_branches" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "entity_id" INT NOT NULL,
    "name" NVARCHAR(100) NOT NULL,
    "code" NVARCHAR(10) UNIQUE NOT NULL,
    "address" NVARCHAR(MAX) NULL,
    "active_flag" BIT DEFAULT 1,
    CONSTRAINT "FK_branch_entity" FOREIGN KEY ("entity_id") REFERENCES "dbo"."sys_entities"("id")
)
GO

-- ============================================================================
-- 18. SYSTEM GOVERNANCE
-- ============================================================================

CREATE TABLE "dbo"."sys_audit_log_entries" (
    "id" BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "user_id" INT NULL,
    "action" NVARCHAR(50) NOT NULL,
    "table_name" NVARCHAR(100) NULL,
    "record_id" INT NULL,
    "old_value" NVARCHAR(MAX) NULL,
    "new_value" NVARCHAR(MAX) NULL,
    "created_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."sys_notification_templates" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "name" NVARCHAR(100) NOT NULL,
    "subject" NVARCHAR(200) NULL,
    "body" NVARCHAR(MAX) NOT NULL,
    "active_flag" BIT DEFAULT 1
)
GO

CREATE TABLE "dbo"."sys_integration_configs" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "provider_name" NVARCHAR(100) NOT NULL,
    "api_key" NVARCHAR(MAX) NULL,
    "endpoint" NVARCHAR(MAX) NULL,
    "status" NVARCHAR(20) DEFAULT 'active'
)
GO

CREATE TABLE "dbo"."sys_document_sequences" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "document_type" NVARCHAR(50) UNIQUE NOT NULL,
    "prefix" NVARCHAR(10) NULL,
    "next_number" INT DEFAULT 1,
    "padding" INT DEFAULT 5
)
GO

CREATE TABLE "dbo"."sys_api_logs" (
    "id" BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "request_url" NVARCHAR(MAX) NOT NULL,
    "request_method" NVARCHAR(10) NOT NULL,
    "status_code" INT NOT NULL,
    "response_time_ms" INT NULL,
    "created_at" DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE "dbo"."sys_maintenance_mode" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "is_enabled" BIT DEFAULT 0,
    "message" NVARCHAR(MAX) NULL,
    "start_time" DATETIME NULL,
    "end_time" DATETIME NULL
)
GO

CREATE TABLE "dbo"."sys_app_settings" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "setting_key" NVARCHAR(100) UNIQUE NOT NULL,
    "setting_value" NVARCHAR(MAX) NULL,
    "description" NVARCHAR(MAX) NULL
)
GO

CREATE TABLE "dbo"."sys_user_sessions" (
    "id" INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    "user_id" INT NOT NULL,
    "session_token" NVARCHAR(255) UNIQUE NOT NULL,
    "expires_at" DATETIME NOT NULL,
    "created_at" DATETIME DEFAULT GETDATE(),
    CONSTRAINT "FK_sess_user" FOREIGN KEY ("user_id") REFERENCES "dbo"."users"("id") ON DELETE CASCADE
)
GO
 