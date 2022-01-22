# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20220122062031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "lob_bank_account_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "company_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.string   "bank_address"
  end

  create_table "bank_check_events", force: :cascade do |t|
    t.integer  "bank_check_id"
    t.string   "event"
    t.string   "lob_event_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "bank_checks", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "bank_account_id"
    t.string   "lob_bank_check_id"
    t.integer  "bill_id"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "expected_delivery_date"
    t.string   "description"
    t.string   "to_name"
    t.string   "to_address"
    t.string   "to_city"
    t.string   "to_state"
    t.string   "to_country"
    t.string   "to_zip"
    t.string   "from_name"
    t.string   "from_address"
    t.string   "from_city"
    t.string   "from_state"
    t.string   "from_country"
    t.string   "from_zip"
    t.decimal  "amount",                    precision: 10, scale: 2
    t.string   "memo"
    t.string   "check_bottom"
    t.string   "mail_type"
    t.string   "lien_waiver_customer_name"
    t.string   "lien_waiver_message"
    t.boolean  "send_lien_waiver"
    t.string   "lien_waiver_type"
    t.string   "check_type"
  end

  create_table "bid_request_template_scopes_items", force: :cascade do |t|
    t.integer  "vendor_bid_request_id"
    t.integer  "property_work_scope_bid_template_id"
    t.integer  "received_quantity"
    t.integer  "material_cost"
    t.integer  "labor_cost"
    t.integer  "total_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bid_request_template_scopes_items", ["property_work_scope_bid_template_id"], name: "bid_request_item_pwscope_bid_template_index", using: :btree
  add_index "bid_request_template_scopes_items", ["vendor_bid_request_id"], name: "item_vendor_bid_request_index", using: :btree

  create_table "bill_attachments", force: :cascade do |t|
    t.integer  "bill_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "order"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "is_lien_waiver"
  end

  create_table "bill_budget_categories", force: :cascade do |t|
    t.integer  "bill_id"
    t.integer  "budget_category_id"
    t.decimal  "cost",               precision: 10, scale: 2
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "bill_contract_milestones", force: :cascade do |t|
    t.integer  "bill_id"
    t.integer  "vendor_contract_milestone_id"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.decimal  "cost",                         precision: 10, scale: 2
  end

  create_table "bill_cost_codes", force: :cascade do |t|
    t.integer  "bill_id"
    t.integer  "cost_code_id"
    t.decimal  "cost",         precision: 10, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "bill_lien_waivers", force: :cascade do |t|
    t.integer  "bill_id"
    t.string   "waiver_type"
    t.string   "signature_fields"
    t.string   "signature_document_id"
    t.string   "signature_status"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "bill_attachment_id"
    t.boolean  "reviewed"
    t.integer  "review_user_id"
    t.string   "signature_document_url"
  end

  create_table "bill_messages", force: :cascade do |t|
    t.integer  "bill_id"
    t.integer  "user_id"
    t.string   "message"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "notify_borrower",   default: false
    t.boolean  "notify_inspector",  default: false
    t.boolean  "notify_lender",     default: false
    t.boolean  "notification_sent", default: false
  end

  create_table "bills", force: :cascade do |t|
    t.integer  "property_id"
    t.decimal  "cost",                                         precision: 10, scale: 2
    t.integer  "vendor_id"
    t.boolean  "payable_to_owner"
    t.integer  "draw_id"
    t.datetime "created_at",                                                                                      null: false
    t.datetime "updated_at",                                                                                      null: false
    t.string   "invoice_number"
    t.string   "bill_id"
    t.string   "job"
    t.string   "cost_code_deprecated"
    t.string   "lien_waiver_type_deprecated",                                           default: "None required"
    t.text     "lien_waiver_signature_fields_deprecated"
    t.string   "lien_waiver_signature_document_id_deprecated"
    t.string   "lien_waiver_signature_status_deprecated"
    t.string   "related_bill_ids"
    t.string   "payment_method"
    t.integer  "organization_id"
    t.string   "description"
    t.integer  "vendor_contract_milestone_id_deprecated"
    t.string   "approval_status",                                                       default: "approved"
    t.integer  "assigned_user_id"
    t.integer  "approved_user_id"
    t.date     "due_date"
    t.text     "approval_reason"
    t.string   "bill_check_memo"
    t.text     "no_milestone_reason"
    t.boolean  "is_extra",                                                              default: false
    t.text     "assigners_comment"
  end

  create_table "budget_categories", force: :cascade do |t|
    t.integer  "property_id"
    t.string   "acct_no"
    t.string   "description"
    t.decimal  "orig_estimate",        precision: 10, scale: 2
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.boolean  "claim_unused",                                  default: false
    t.decimal  "forecast",             precision: 10, scale: 2
    t.text     "forecast_notes"
    t.integer  "budget_id"
    t.string   "cost_code_deprecated"
    t.integer  "cost_code_id"
    t.text     "note"
    t.text     "prelim_specs"
    t.decimal  "prelim",               precision: 10, scale: 2
    t.decimal  "value_eng",            precision: 10, scale: 2
    t.text     "value_eng_specs"
    t.decimal  "hard_bid",             precision: 10, scale: 2
    t.text     "hard_bid_specs"
    t.decimal  "target",               precision: 10, scale: 2
    t.text     "target_specs"
    t.decimal  "negotiated",           precision: 10, scale: 2
    t.text     "negotiated_specs"
    t.string   "remark"
    t.decimal  "updated_prelim",       precision: 10, scale: 2
    t.text     "updated_prelim_specs"
  end

  add_index "budget_categories", ["cost_code_id"], name: "index_budget_categories_on_cost_code_id", using: :btree

  create_table "budget_category_changes", force: :cascade do |t|
    t.integer  "budget_category_id"
    t.decimal  "delta",              precision: 10, scale: 2
    t.string   "reason"
    t.integer  "draw_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "budgets", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "is_default"
    t.integer  "property_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "approval_status"
    t.text     "approval_reason"
    t.integer  "reference_properties_ids", default: [],              array: true
    t.integer  "reference_budget_id"
    t.text     "exclusions"
    t.text     "terms_and_conditions"
    t.text     "additional_notes"
  end

  create_table "cost_codes", force: :cascade do |t|
    t.string   "code"
    t.string   "description"
    t.boolean  "is_contingency"
    t.decimal  "cost_per_thousand_sf"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "organization_id"
    t.boolean  "is_soft",              default: false
    t.string   "parent_cost_code"
    t.boolean  "is_material"
    t.string   "material_color_code"
    t.string   "remark"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "draw_attachments", force: :cascade do |t|
    t.integer  "draw_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "signature_document_id"
    t.string   "signature_status"
  end

  create_table "draws", force: :cascade do |t|
    t.integer  "property_id"
    t.integer  "draw_number"
    t.date     "request_date"
    t.date     "fund_received_date"
    t.string   "budget_code"
    t.string   "budget_notes"
    t.boolean  "has_generated_change_order",                                    default: false
    t.datetime "created_at",                                                                    null: false
    t.datetime "updated_at",                                                                    null: false
    t.decimal  "reclaim_needed",                       precision: 10, scale: 2
    t.string   "approval_status"
    t.text     "approval_reason"
    t.string   "escrow_deposit_signature_document_id"
    t.string   "escrow_deposit_signature_status"
  end

  create_table "fundcontrol_providers", force: :cascade do |t|
    t.string   "name"
    t.string   "provider_type"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "draw_report_recipient_emails"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "inspection_report_draw_item_pics", force: :cascade do |t|
    t.integer  "inspection_report_draw_item_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.integer  "order"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "inspection_report_draw_items", force: :cascade do |t|
    t.integer  "inspection_report_id"
    t.string   "status"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.decimal  "pct_budget_used",      precision: 10, scale: 2
    t.string   "pct_completed"
    t.integer  "budget_category_id"
    t.decimal  "cost",                 precision: 10, scale: 2
  end

  create_table "inspection_report_job_card_pics", force: :cascade do |t|
    t.integer  "inspection_report_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.integer  "order"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "inspection_report_pics", force: :cascade do |t|
    t.integer  "inspection_report_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.integer  "order"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "inspection_reports", force: :cascade do |t|
    t.integer  "draw_id"
    t.integer  "inspection_user_id"
    t.text     "report_detail"
    t.string   "report_status"
    t.date     "report_date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "percentage_completed"
    t.integer  "num_workers_on_site"
    t.string   "materials_stored_onsite"
    t.boolean  "contractors_on_site"
    t.text     "weather"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "inspector_mileages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "miles_driven"
    t.date     "date_driven"
    t.integer  "organization_id"
    t.integer  "draw_id"
    t.integer  "property_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "leads", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.text     "message"
    t.string   "referrer_url"
    t.string   "signup_url"
    t.string   "auth_token"
    t.boolean  "email_notification_general"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "loan_escrow_activities", force: :cascade do |t|
    t.integer "loan_escrow_id"
    t.string  "activity_type"
    t.string  "activity_description"
    t.string  "payer_name"
    t.string  "payee_name"
    t.string  "payment_method"
    t.string  "payment_reference"
    t.decimal "amount",               precision: 10, scale: 2
  end

  create_table "loan_escrows", force: :cascade do |t|
    t.integer  "loan_id"
    t.string   "vendor_name"
    t.string   "external_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "loans", force: :cascade do |t|
    t.integer  "property_id"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "interest_rate",   precision: 10, scale: 4
    t.decimal  "principle",       precision: 10, scale: 2
    t.text     "description"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "approval_status"
    t.text     "approval_reason"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.text     "message"
    t.boolean  "archived",            default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "from_vendor_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string  "name"
    t.string  "address"
    t.string  "city"
    t.string  "zip_code"
    t.string  "domain_name"
    t.boolean "is_lender",                  default: false
    t.integer "notification_user_id"
    t.string  "state"
    t.boolean "bill_approval_required",     default: false
    t.string  "ticket_notification_emails"
    t.string  "insurance_approver_name"
    t.string  "insurance_approver_email"
  end

  create_table "properties", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "status"
    t.boolean  "featured"
    t.string   "address"
    t.string   "city"
    t.integer  "zip_code"
    t.integer  "lot_size"
    t.integer  "sq_ft"
    t.integer  "num_beds"
    t.float    "num_baths"
    t.integer  "num_garages"
    t.string   "mls_num"
    t.float    "lattitude"
    t.float    "longitude"
    t.integer  "price"
    t.string   "finish_date"
    t.string   "slug"
    t.string   "walkthrough_url"
    t.text     "description"
    t.text     "school_description"
    t.string   "video_url"
    t.text     "meta_description"
    t.boolean  "walkthrough_inline"
    t.string   "walkthrough_cover_url"
    t.integer  "agent_user_id"
    t.text     "agent_signature_html"
    t.boolean  "show_project_updates",                                     default: false
    t.boolean  "show_live_video",                                          default: false
    t.string   "fundcontrol_job_name"
    t.string   "fundcontrol_disbursement_number"
    t.string   "fundcontrol_owner_name"
    t.string   "status_display"
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
    t.integer  "gc_vendor_id"
    t.string   "fundcontrol_lender_name"
    t.string   "fundcontrol_owner_email"
    t.string   "fundcontrol_recipient_emails"
    t.integer  "organization_id"
    t.string   "escrow_bank_name"
    t.string   "escrow_address"
    t.string   "escrow_contact_name"
    t.string   "escrow_email"
    t.string   "daca_signature_document_id"
    t.string   "daca_signature_status"
    t.string   "escrow_deposit_account"
    t.integer  "inspector_user_id"
    t.integer  "fundcontrol_provider_id"
    t.integer  "bank_account_id"
    t.text     "additionally_insured"
    t.string   "state"
    t.string   "live_video_url"
    t.string   "live_photo_url"
    t.string   "youtube_playlist_id"
    t.string   "holobuilder_link"
    t.integer  "main_floor_area"
    t.integer  "second_floor_area"
    t.integer  "basement"
    t.integer  "garage_area"
    t.integer  "extra_height"
    t.integer  "adu"
    t.integer  "porch"
    t.decimal  "patio",                           precision: 10, scale: 2
    t.integer  "third_floor_area"
    t.integer  "fourth_floor_area"
    t.integer  "fifth_floor_area"
    t.integer  "sixth_floor_area"
    t.integer  "seventh_floor_area"
    t.integer  "building_one_area"
    t.integer  "building_two_area"
    t.integer  "building_three_area"
    t.integer  "building_four_area"
    t.integer  "building_five_area"
    t.integer  "project_manager_user_id"
    t.text     "insurance_certificate_holder"
    t.integer  "qa_user_id"
  end

  create_table "property_bid_template_attachments", force: :cascade do |t|
    t.integer  "property_bid_template_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "property_bid_templates", force: :cascade do |t|
    t.integer "property_id"
    t.string  "from_name"
    t.string  "reply_to_email"
    t.text    "body"
    t.string  "subject"
    t.string  "name"
  end

  create_table "property_gantt_histories", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "property_id"
    t.integer  "user_id"
  end

  create_table "property_material_disclosures", force: :cascade do |t|
    t.integer  "property_id"
    t.string   "signature_document_id"
    t.string   "signature_status"
    t.string   "recipient_email"
    t.text     "property_material_ids"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "property_material_dot_mappings", force: :cascade do |t|
    t.integer  "property_material_id"
    t.integer  "property_plan_dot_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "property_material_pics", force: :cascade do |t|
    t.integer  "property_material_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.integer  "order"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "property_material_trackings", force: :cascade do |t|
    t.integer  "property_material_id"
    t.integer  "quantity"
    t.string   "status"
    t.string   "tracking_number"
    t.string   "order_number"
    t.date     "delivery_date"
    t.string   "receiver"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "property_materials", force: :cascade do |t|
    t.integer  "property_id"
    t.string   "name"
    t.string   "description"
    t.string   "location"
    t.string   "source_url"
    t.date     "delivered_on_date"
    t.date     "shipped_date"
    t.date     "need_by_date"
    t.date     "order_by_date"
    t.text     "notes"
    t.integer  "quantities"
    t.string   "image_url"
    t.integer  "budget_category_id"
    t.date     "expected_delivery_date"
    t.integer  "verify_user_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "status_updated_at"
    t.string   "installation_spec_file_name"
    t.string   "installation_spec_content_type"
    t.integer  "installation_spec_file_size"
    t.datetime "installation_spec_updated_at"
    t.string   "spec_sheet_file_name"
    t.string   "spec_sheet_content_type"
    t.integer  "spec_sheet_file_size"
    t.datetime "spec_sheet_updated_at"
    t.string   "image_upload_file_name"
    t.string   "image_upload_content_type"
    t.integer  "image_upload_file_size"
    t.datetime "image_upload_updated_at"
    t.decimal  "item_cost",                      default: 0.0
    t.boolean  "approved",                       default: false
    t.datetime "approval_date"
  end

  create_table "property_pics", force: :cascade do |t|
    t.integer  "property_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.integer  "order"
    t.boolean  "featured"
    t.string   "room_name"
    t.text     "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "property_plan_dots", force: :cascade do |t|
    t.integer "property_plan_id"
    t.integer "budget_category_id"
    t.float   "x"
    t.float   "y"
    t.text    "annotation"
  end

  create_table "property_plans", force: :cascade do |t|
    t.integer  "property_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.integer  "order"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "property_roles", force: :cascade do |t|
    t.integer  "property_organization_id"
    t.integer  "property_id"
    t.integer  "role_organization_id"
    t.integer  "role_user_id"
    t.string   "role_type"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "property_trade_mappings", force: :cascade do |t|
    t.integer  "property_id"
    t.integer  "vendor_trade_id"
    t.integer  "quantity"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "property_utilities", force: :cascade do |t|
    t.integer  "property_id"
    t.string   "utility_type"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "reference"
    t.text     "next_step"
    t.text     "blocked_on"
    t.date     "estimated_completion"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "status"
  end

  create_table "property_utility_notes", force: :cascade do |t|
    t.integer  "property_utility_id"
    t.text     "note"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "property_work_scope_bid_templates", force: :cascade do |t|
    t.integer  "property_work_scope_id"
    t.integer  "property_bid_template_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "property_work_scopes", force: :cascade do |t|
    t.integer  "property_id"
    t.integer  "cost_code_id"
    t.string   "unit"
    t.integer  "quantity"
    t.string   "scope_clarifications"
    t.string   "sheet_references"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.text     "material_type_specs"
  end

  create_table "qa_checklist_item_pics", force: :cascade do |t|
    t.integer  "qa_checklist_item_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "vendor_user_id"
  end

  create_table "qa_checklist_item_remarks", force: :cascade do |t|
    t.integer  "qa_checklist_item_id"
    t.integer  "vendor_user_id"
    t.integer  "user_id"
    t.string   "body"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "qa_checklist_item_status_histories", force: :cascade do |t|
    t.integer  "qa_checklist_item_id"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "qa_checklist_items", force: :cascade do |t|
    t.integer  "qa_checklist_id"
    t.string   "name"
    t.string   "description"
    t.date     "date_raised"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "issue_rectified", default: false
  end

  create_table "qa_checklists", force: :cascade do |t|
    t.integer  "vendor_trade_id"
    t.integer  "task_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "sms_message_pics", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "sms_message_threads", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "organization_id"
    t.integer  "task_id"
  end

  add_index "sms_message_threads", ["task_id"], name: "index_sms_message_threads_on_task_id", using: :btree

  create_table "sms_messages", force: :cascade do |t|
    t.string   "from"
    t.string   "from_zip"
    t.string   "from_city"
    t.string   "from_state"
    t.string   "from_country"
    t.string   "to"
    t.string   "to_zip"
    t.string   "to_city"
    t.string   "to_state"
    t.string   "to_country"
    t.string   "sms_message_sid"
    t.string   "num_media"
    t.string   "sms_sid"
    t.string   "sms_status"
    t.string   "body"
    t.string   "message_sid"
    t.string   "account_sid"
    t.string   "api_version"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "sms_message_thread_id"
    t.string   "media_url"
    t.string   "error_message"
    t.string   "body_spanish"
    t.integer  "from_vendor_user_id"
    t.integer  "from_user_id"
  end

  create_table "sms_numbers", force: :cascade do |t|
    t.string   "sms_number"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "organization_id"
  end

  create_table "task_attachments", force: :cascade do |t|
    t.integer  "task_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "task_edges", force: :cascade do |t|
    t.integer "from_task_id"
    t.integer "to_task_id"
    t.integer "property_id"
    t.string  "link_type"
    t.integer "lag",          default: 0
  end

  create_table "task_pics", force: :cascade do |t|
    t.integer  "task_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.string   "name"
    t.integer  "order"
    t.boolean  "final",            default: false
    t.integer  "user_id"
    t.integer  "vendor_user_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "task_snapshots", force: :cascade do |t|
    t.integer  "property_id"
    t.string   "snapshot_file_name"
    t.string   "snapshot_content_type"
    t.integer  "snapshot_file_size"
    t.datetime "snapshot_updated_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "property_id"
    t.integer "vendor_id"
    t.string  "name"
    t.date    "planned_start_date"
    t.integer "duration_days"
    t.string  "status"
    t.string  "phase"
    t.integer "original_duration_days"
    t.text    "notes"
    t.date    "need_by_date"
    t.integer "user_id"
    t.string  "functional_area"
    t.integer "sms_message_thread_id"
    t.string  "priority"
    t.integer "parent"
    t.integer "sort_order",                                     default: 0
    t.string  "task_type"
    t.decimal "progress",               precision: 8, scale: 2, default: 0.0
  end

  create_table "ticket_attachments", force: :cascade do |t|
    t.integer  "ticket_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "order"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "ticket_counts", force: :cascade do |t|
    t.string   "status"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_notes", force: :cascade do |t|
    t.integer  "ticket_id"
    t.text     "note"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "author_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "property_id"
    t.integer  "assigned_vendor_id"
    t.string   "serial_number"
    t.text     "description"
    t.integer  "gc_vendor_id"
    t.string   "status"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.date     "schedule_date"
    t.integer  "author_user_id"
    t.string   "blocked_on"
    t.string   "approval_status"
    t.integer  "approved_user_id"
    t.text     "approval_reason"
    t.decimal  "cost",                  precision: 10, scale: 2
    t.boolean  "is_internal",                                    default: false
    t.integer  "sms_message_thread_id"
    t.date     "end_date"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                     default: "",    null: false
    t.string   "encrypted_password",                        default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                           default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.boolean  "is_admin",                                  default: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "phone"
    t.date     "birthday"
    t.boolean  "accredit_networth",                         default: false
    t.boolean  "accredit_joint_income",                     default: false
    t.boolean  "accredit_individual_income",                default: false
    t.boolean  "accredit_none",                             default: false
    t.boolean  "accredit_accepted_terms",                   default: false
    t.boolean  "email_notification_general",                default: true
    t.string   "investment_size"
    t.string   "mailchimp_leid"
    t.string   "fa_entity_id"
    t.string   "referred_by"
    t.boolean  "email_notification_my_project_updates",     default: true
    t.boolean  "email_notification_other_projects_updates", default: true
    t.boolean  "is_agent",                                  default: false
    t.text     "buyer_profile_raw"
    t.boolean  "is_investor"
    t.boolean  "is_buyer"
    t.text     "investor_profile_raw"
    t.string   "referrer_url"
    t.string   "signup_url"
    t.string   "ownership_type"
    t.string   "child_entity_name"
    t.string   "child_entity_state_formed"
    t.string   "child_entity_address"
    t.string   "child_entity_city"
    t.string   "child_entity_state"
    t.string   "child_entity_phone"
    t.string   "child_entity_zip_code"
    t.string   "child_entity_title"
    t.string   "fa_parent_entity_id"
    t.string   "fa_investor_id"
    t.string   "sdira_vesting_name"
    t.string   "sdira_account_number"
    t.string   "sdira_entity_name"
    t.string   "sdira_entity_address"
    t.string   "sdira_entity_city"
    t.string   "sdira_entity_state"
    t.string   "sdira_entity_zip_code"
    t.string   "sdira_entity_email"
    t.string   "sdira_entity_phone"
    t.string   "sdira_entity_contact_name"
    t.string   "auth_token"
    t.integer  "organization_id"
    t.boolean  "is_inspector",                              default: false
    t.boolean  "can_submit_draw",                           default: false
    t.boolean  "is_gc",                                     default: false
    t.boolean  "can_send_check",                            default: false
    t.boolean  "is_property_owner",                         default: false
    t.string   "mobile_phone"
    t.string   "office_phone"
    t.boolean  "is_contract_approver",                      default: false
    t.boolean  "is_ticket_approver"
    t.boolean  "is_ticket_administrator"
    t.boolean  "is_task_owner"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "is_project_manager",                        default: false
    t.boolean  "is_qa",                                     default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendor_bid_request_attachments", force: :cascade do |t|
    t.integer  "vendor_bid_request_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "vendor_bid_requests", force: :cascade do |t|
    t.integer  "vendor_id"
    t.integer  "property_id"
    t.string   "from_name"
    t.string   "reply_to_email"
    t.integer  "property_bid_template_id"
    t.text     "body"
    t.string   "status"
    t.date     "last_remind_date"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.date     "sent_date"
    t.decimal  "bid_amount",               precision: 10, scale: 2
    t.string   "subject"
    t.integer  "vendor_trade_id"
    t.boolean  "all_inclusive",                                     default: false
    t.text     "notes"
    t.integer  "sms_message_thread_id"
    t.integer  "quantity"
  end

  create_table "vendor_contract_approvals", force: :cascade do |t|
    t.integer  "vendor_contract_id"
    t.integer  "approve_user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "vendor_contract_attachments", force: :cascade do |t|
    t.integer  "vendor_contract_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "description"
    t.integer  "order"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "signature_document_id"
    t.string   "signature_status"
    t.string   "name"
    t.boolean  "generated"
  end

  create_table "vendor_contract_milestones", force: :cascade do |t|
    t.integer  "vendor_contract_id"
    t.string   "name"
    t.string   "description"
    t.decimal  "amount",                     precision: 10, scale: 2
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.date     "due_date"
    t.date     "start_date"
    t.decimal  "per_diem_liquidated_damage", precision: 10, scale: 2
    t.integer  "milestone_duration"
  end

  create_table "vendor_contract_penalties", force: :cascade do |t|
    t.integer  "vendor_contract_id"
    t.integer  "delay_from_day"
    t.integer  "delay_to_day"
    t.integer  "penalty_pct"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "vendor_contract_properties", force: :cascade do |t|
    t.integer  "property_id"
    t.integer  "vendor_contract_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "vendor_contracts", force: :cascade do |t|
    t.integer  "vendor_id"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "description"
    t.decimal  "value",                              precision: 10, scale: 2
    t.decimal  "pct_completed",                      precision: 10, scale: 2
    t.date     "start_date"
    t.text     "inclusions"
    t.text     "exclusions"
    t.date     "contract_date"
    t.string   "architect_engineer"
    t.text     "penalty_exceptions"
    t.integer  "retainage_pct"
    t.string   "complete_within"
    t.text     "generated_contract_html"
    t.text     "clarifications"
    t.text     "documents"
    t.text     "progress_schedule"
    t.decimal  "per_diem_damage",                    precision: 10, scale: 2
    t.string   "progress_schedule_pic_file_name"
    t.string   "progress_schedule_pic_content_type"
    t.integer  "progress_schedule_pic_file_size"
    t.datetime "progress_schedule_pic_updated_at"
    t.string   "name"
  end

  create_table "vendor_insurance_certs", force: :cascade do |t|
    t.integer  "vendor_contract_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "order"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "upload_user_name"
    t.string   "upload_user_email"
    t.date     "expiry_date"
    t.string   "approval_status"
    t.text     "approval_reason"
    t.string   "approver_email"
    t.string   "approver_name"
    t.boolean  "exempt_workers_comp",     default: false
    t.boolean  "exempt_auto_liability",   default: false
  end

  create_table "vendor_trade_mappings", force: :cascade do |t|
    t.integer  "vendor_id"
    t.integer  "vendor_trade_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "vendor_trades", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "organization_id"
    t.string   "measured_item"
    t.string   "unit_of_measure"
    t.boolean  "is_hidden",       default: false
    t.integer  "cost_code_id"
  end

  create_table "vendor_user_feedbacks", force: :cascade do |t|
    t.integer  "vendor_user_id"
    t.string   "question"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendor_user_ratings", force: :cascade do |t|
    t.integer  "vendor_user_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendor_users", force: :cascade do |t|
    t.string   "phone_number"
    t.integer  "otp"
    t.string   "auth_token"
    t.integer  "vendor_id"
    t.boolean  "confirmed"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "device_token"
    t.string   "preferred_language", default: "english"
  end

  add_index "vendor_users", ["otp"], name: "index_vendor_users_on_otp", unique: true, using: :btree
  add_index "vendor_users", ["phone_number"], name: "index_vendor_users_on_phone_number", unique: true, using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "company_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "type"
    t.string   "payment_method"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "email"
    t.string   "lic_number"
    t.string   "wire_bank_aba_num"
    t.string   "wire_bank_name"
    t.string   "wire_bank_address"
    t.string   "wire_payee_account_num"
    t.string   "wire_payee_address"
    t.string   "wire_payee_name"
    t.integer  "organization_id"
    t.string   "contact_name"
    t.string   "mobile_phone"
    t.string   "office_phone"
    t.integer  "admin_user_id"
    t.string   "license_number"
    t.boolean  "unlicensed"
    t.boolean  "is_lead"
    t.string   "additional_emails"
    t.string   "field_person_mobile_phone"
    t.string   "field_person_first_name"
    t.string   "field_person_last_name"
    t.string   "preferred_language",        default: "english"
    t.boolean  "is_unsubscribed",           default: false
    t.datetime "unsubscribed_at"
    t.string   "unsubscribe_reason"
  end

  create_table "webhook_event_logs", force: :cascade do |t|
    t.string   "event_type"
    t.text     "params"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
