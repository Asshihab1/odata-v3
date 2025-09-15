-- CreateTable
CREATE TABLE `absence_requests` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `absence_type_id` BIGINT UNSIGNED NULL,
    `start` DATETIME(0) NOT NULL,
    `end` DATETIME(0) NOT NULL,
    `total_hour` DOUBLE NULL,
    `status` VARCHAR(255) NOT NULL,
    `approved_by` BIGINT UNSIGNED NULL,
    `applicant_note` TEXT NULL,
    `supervisor_note` TEXT NULL,
    `approval_time` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_read` BOOLEAN NOT NULL DEFAULT false,
    `graph_id` VARCHAR(255) NULL,
    `is_full_day` BOOLEAN NOT NULL DEFAULT false,

    INDEX `absence_requests_absence_type_id_foreign`(`absence_type_id`),
    INDEX `absence_requests_approved_by_foreign`(`approved_by`),
    INDEX `absence_requests_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `absence_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `absence_types_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `action_meetings` (
    `action_setting_id` BIGINT UNSIGNED NOT NULL,
    `meeting_id` BIGINT UNSIGNED NOT NULL,

    INDEX `action_meetings_action_setting_id_foreign`(`action_setting_id`),
    INDEX `action_meetings_meeting_id_foreign`(`meeting_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `action_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `sort_order` INTEGER NULL DEFAULT 0,
    `color` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `area_user` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `area_id` BIGINT UNSIGNED NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `area_user_area_id_foreign`(`area_id`),
    INDEX `area_user_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `areas` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(100) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `areas_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attribute_set_options` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `attribute_set_id` BIGINT UNSIGNED NOT NULL,
    `custom_id` VARCHAR(255) NOT NULL,
    `valuation` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `attribute_set_options_attribute_set_id_custom_id_unique`(`attribute_set_id`, `custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attribute_sets` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `plant_id` BIGINT UNSIGNED NOT NULL,
    `custom_id` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `internal_id` VARCHAR(255) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `name` VARCHAR(255) NULL,

    UNIQUE INDEX `attribute_sets_plant_id_custom_id_unique`(`plant_id`, `custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `backlog_item_weeks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `backlog_item_id` BIGINT UNSIGNED NOT NULL,
    `week` INTEGER NOT NULL,
    `year` INTEGER NOT NULL,
    `qty_prod_order` DOUBLE NOT NULL,
    `qty_call_off` DOUBLE NOT NULL,
    `qty_stock` DOUBLE NOT NULL,
    `qty_backlog` DOUBLE NOT NULL,
    `qty_call_off_sim` DOUBLE NOT NULL,
    `qty_stock_sim` DOUBLE NOT NULL,
    `qty_backlog_sim` DOUBLE NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `backlog_item_weeks_backlog_item_id_index`(`backlog_item_id`),
    UNIQUE INDEX `backlog_item_weeks_backlog_item_id_week_year_unique`(`backlog_item_id`, `week`, `year`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `backlog_items` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `is_critical` BOOLEAN NOT NULL DEFAULT false,
    `is_critical_sim` BOOLEAN NOT NULL DEFAULT false,
    `qty_call_off` DOUBLE NOT NULL DEFAULT 0,
    `qty_stock` DOUBLE NOT NULL DEFAULT 0,
    `qty_backlog` DOUBLE NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `qty_prod_order` DOUBLE NOT NULL DEFAULT 0,

    INDEX `backlog_items_item_id_foreign`(`item_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `bom_pos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `bom_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NOT NULL,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `custom_pos` VARCHAR(255) NULL,
    `qty_for_one_parent` DOUBLE NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `unit_of_measure_id` BIGINT UNSIGNED NULL,

    INDEX `bom_pos_item_id_foreign`(`item_id`),
    INDEX `bom_pos_unit_of_measure_id_foreign`(`unit_of_measure_id`),
    UNIQUE INDEX `bom_pos_bom_id_pos_unique`(`bom_id`, `pos`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `boms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `boms_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_additional_heat_treatments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_id` BIGINT UNSIGNED NOT NULL,
    `pos` INTEGER NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `calc_add_heat_treatments_calculation_id_pos_type_unique`(`calculation_id`, `pos`, `type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_chem_analyses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_id` BIGINT UNSIGNED NOT NULL,
    `chem_analysis_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `calculation_chem_analyses_calculation_id_foreign`(`calculation_id`),
    INDEX `calculation_chem_analyses_chem_analysis_id_foreign`(`chem_analysis_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_chemical_analyses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `min` DOUBLE NULL,
    `max` DOUBLE NULL,
    `unit` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `calculation_material_analysis_id` BIGINT UNSIGNED NULL,

    INDEX `calculation_chemical_analyses_cma_frn`(`calculation_material_analysis_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_deformations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_id` BIGINT UNSIGNED NULL,
    `deformation_id` BIGINT UNSIGNED NULL,
    `custom_id` VARCHAR(255) NOT NULL,
    `continuous_casting` VARCHAR(255) NULL,
    `ingot_casting` VARCHAR(255) NULL,
    `stretch_forging_degree` VARCHAR(255) NULL,
    `note` VARCHAR(255) NULL,
    `deformation` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `calculation_deformations_calculation_id_foreign`(`calculation_id`),
    INDEX `calculation_deformations_deformation_id_foreign`(`deformation_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_documentation_certificates` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_documentation_id` BIGINT UNSIGNED NOT NULL,
    `certificate` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `calculation_documentation_certificate_unique_index`(`calculation_documentation_id`, `certificate`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_documentations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_id` BIGINT UNSIGNED NOT NULL,
    `documentation_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NULL,
    `charge` BOOLEAN NOT NULL DEFAULT false,
    `melting_process` BOOLEAN NOT NULL DEFAULT false,
    `cleanliness_of_the_charge` BOOLEAN NOT NULL DEFAULT false,
    `cleanliness_of_the_component` BOOLEAN NOT NULL DEFAULT false,
    `grainsize_of_the_charge` BOOLEAN NOT NULL DEFAULT false,
    `grainsize_of_the_component` BOOLEAN NOT NULL DEFAULT false,
    `product_analysis` BOOLEAN NOT NULL DEFAULT false,
    `jominy` BOOLEAN NOT NULL DEFAULT false,
    `heattreamtment` BOOLEAN NOT NULL DEFAULT false,
    `heattreamtment_with_diagram` BOOLEAN NOT NULL DEFAULT false,
    `deformation` BOOLEAN NOT NULL DEFAULT false,
    `hardness_testing_hbw` BOOLEAN NOT NULL DEFAULT false,
    `hardness_testing_hbw_per_piece` BOOLEAN NOT NULL DEFAULT false,
    `conversion_acc_iso_18265_table_a_1` BOOLEAN NOT NULL DEFAULT false,
    `conversion_acc_iso_18265_table_b_2` BOOLEAN NOT NULL DEFAULT false,
    `pmi` BOOLEAN NOT NULL DEFAULT false,
    `visual_inspection` BOOLEAN NOT NULL DEFAULT false,
    `indication_of_the_surface_condition` BOOLEAN NOT NULL DEFAULT false,
    `dimension_control` BOOLEAN NOT NULL DEFAULT false,
    `dimension_protocol` BOOLEAN NOT NULL DEFAULT false,
    `residual_magnetic_field_strength` BOOLEAN NOT NULL DEFAULT false,
    `radioactivity_freedom_confirmation` BOOLEAN NOT NULL DEFAULT false,
    `confirmation_of_the_absence_of_flakes` BOOLEAN NOT NULL DEFAULT false,
    `create_forging_schedule` BOOLEAN NOT NULL DEFAULT false,
    `create_specimen_plan` BOOLEAN NOT NULL DEFAULT false,
    `create_us_test_instruction` BOOLEAN NOT NULL DEFAULT false,
    `create_mpe_test_instruction` BOOLEAN NOT NULL DEFAULT false,
    `create_fe_test_instruction` BOOLEAN NOT NULL DEFAULT false,
    `create_manufacturing_plan` BOOLEAN NOT NULL DEFAULT false,
    `create_heat_treatment_plan` BOOLEAN NOT NULL DEFAULT false,
    `test_sequence_plan` BOOLEAN NOT NULL DEFAULT false,
    `get_approval_from_the_client` BOOLEAN NOT NULL DEFAULT false,
    `initial_inspection` BOOLEAN NOT NULL DEFAULT false,
    `concentricity_check` BOOLEAN NOT NULL DEFAULT false,
    `create_furnace_position_plan` BOOLEAN NOT NULL DEFAULT false,
    `text` VARCHAR(255) NULL,
    `regulation` VARCHAR(255) NULL,
    `issue_revision` VARCHAR(255) NULL,
    `check_machine_feasibility` BOOLEAN NOT NULL DEFAULT false,
    `check_ik` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `offer_note` VARCHAR(255) NULL,
    `marking` VARCHAR(255) NULL,
    `acceptance` BOOLEAN NOT NULL DEFAULT false,
    `fpp_nr` VARCHAR(255) NULL,
    `fpp_rev` VARCHAR(255) NULL,
    `process_route` VARCHAR(255) NULL,

    INDEX `calculation_documentations_documentation_id_foreign`(`documentation_id`),
    UNIQUE INDEX `calculation_documentations_unique_index`(`calculation_id`, `documentation_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_hardenability_range_material` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_hardenability_range_id` BIGINT UNSIGNED NOT NULL,
    `material_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `chrm_calc_harden_ability_range_id_foreign`(`calculation_hardenability_range_id`),
    INDEX `chrm_material_id_foreign`(`material_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_hardenability_ranges` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_id` BIGINT UNSIGNED NOT NULL,
    `with_applicable_standard` VARCHAR(255) NULL,
    `note` VARCHAR(255) NULL,
    `jominy_batch` VARCHAR(255) NULL,
    `value_1_5_min` DOUBLE NULL,
    `value_1_5_max` DOUBLE NULL,
    `value_3_min` DOUBLE NULL,
    `value_3_max` DOUBLE NULL,
    `value_5_min` DOUBLE NULL,
    `value_5_max` DOUBLE NULL,
    `value_7_min` DOUBLE NULL,
    `value_7_max` DOUBLE NULL,
    `value_9_min` DOUBLE NULL,
    `value_9_max` DOUBLE NULL,
    `value_10_min` DOUBLE NULL,
    `value_10_max` DOUBLE NULL,
    `value_11_min` DOUBLE NULL,
    `value_11_max` DOUBLE NULL,
    `value_13_min` DOUBLE NULL,
    `value_13_max` DOUBLE NULL,
    `value_15_min` DOUBLE NULL,
    `value_15_max` DOUBLE NULL,
    `value_20_min` DOUBLE NULL,
    `value_20_max` DOUBLE NULL,
    `value_25_min` DOUBLE NULL,
    `value_25_max` DOUBLE NULL,
    `value_30_min` DOUBLE NULL,
    `value_30_max` DOUBLE NULL,
    `value_35_min` DOUBLE NULL,
    `value_35_max` DOUBLE NULL,
    `value_40_min` DOUBLE NULL,
    `value_40_max` DOUBLE NULL,
    `value_45_min` DOUBLE NULL,
    `value_45_max` DOUBLE NULL,
    `value_50_min` DOUBLE NULL,
    `value_50_max` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `hardenability_range_id` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `calculation_hardenability_ranges_calculation_id_unique`(`calculation_id`),
    INDEX `calculation_hardenability_ranges_hardenability_range_id_foreign`(`hardenability_range_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_heat_treatments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_id` BIGINT UNSIGNED NOT NULL,
    `pos` INTEGER NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `internal_note` VARCHAR(255) NULL,

    UNIQUE INDEX `calculation_heat_treatments_calculation_id_pos_type_unique`(`calculation_id`, `pos`, `type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_material_analyses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_id` BIGINT UNSIGNED NOT NULL,
    `regulation` VARCHAR(255) NULL,
    `issue_revision` VARCHAR(255) NOT NULL,
    `note` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `material_analysis_id` BIGINT UNSIGNED NULL,

    INDEX `calculation_material_analyses_calculation_id_foreign`(`calculation_id`),
    INDEX `calculation_material_analyses_material_analysis_id_foreign`(`material_analysis_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_material_analysis_material` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_material_analysis_id` BIGINT UNSIGNED NOT NULL,
    `material_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `cmam_calc_material_analyses_id_foreign`(`calculation_material_analysis_id`),
    INDEX `cmam_material_id_foreign`(`material_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_metallographies` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `metallography_id` BIGINT UNSIGNED NOT NULL,
    `calculation_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NULL,
    `regulation` VARCHAR(255) NULL,
    `issue_revision` VARCHAR(255) NULL,
    `grain_size` VARCHAR(255) NULL,
    `grain_size_after_carburizing` VARCHAR(255) NULL,
    `grain_size_determination_according_to` VARCHAR(255) NULL,
    `grain_size_textfield` VARCHAR(255) NULL,
    `cleanliness_determination` VARCHAR(255) NULL,
    `cleanliness_50602_astma45_sep1570` VARCHAR(255) NULL,
    `cleanliness_textfield` VARCHAR(255) NULL,
    `a_fine` DOUBLE NULL,
    `a_coarse` DOUBLE NULL,
    `b_fine` DOUBLE NULL,
    `b_coarse` DOUBLE NULL,
    `c_fine` DOUBLE NULL,
    `c_coarse` DOUBLE NULL,
    `d_fine` DOUBLE NULL,
    `d_coarse` DOUBLE NULL,
    `ds` DOUBLE NULL,
    `image` BOOLEAN NOT NULL DEFAULT false,
    `needs_microsection_structure` BOOLEAN NOT NULL DEFAULT false,
    `needs_microsection_grain_size` BOOLEAN NOT NULL DEFAULT false,
    `needs_microsection_carburized` BOOLEAN NOT NULL DEFAULT false,
    `needs_microsection_cleanliness` BOOLEAN NOT NULL DEFAULT false,
    `microstructure_assessment` VARCHAR(255) NULL,
    `microstructure_quota` VARCHAR(255) NULL,
    `microstructure_max_quota` DOUBLE NULL,
    `microstructure_textfield` VARCHAR(255) NULL,
    `needs_ic_according_to` VARCHAR(255) NULL,
    `needs_ic_simulation_annealing` BOOLEAN NOT NULL DEFAULT false,
    `needs_ic_external_testing` BOOLEAN NOT NULL DEFAULT false,
    `needs_ic_textfield` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `offer_note` VARCHAR(255) NULL,
    `cleanliness_max_value` DOUBLE NULL,
    `grain_size_value` DOUBLE NULL,
    `wb_parameter` DOUBLE NULL,

    UNIQUE INDEX `calculation_metallographies_calculation_id_unique`(`calculation_id`),
    INDEX `metallography_id_foreign`(`metallography_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_metallography_cleanliness_determination_accordings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_metallography_id` BIGINT UNSIGNED NOT NULL,
    `cleanliness_determination_according_to` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `calc_metallo_id_clean_deter_accord_to_index`(`calculation_metallography_id`, `cleanliness_determination_according_to`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_non_destructive_norms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_non_destructive_testing_id` BIGINT UNSIGNED NOT NULL,
    `norm_type` VARCHAR(255) NOT NULL,
    `norm_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `calculation_non_destructive_norms_norm_type_norm_id_index`(`norm_type`, `norm_id`),
    INDEX `calculation_non_destructive_testing_id_foreign_key`(`calculation_non_destructive_testing_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_non_destructive_testing_attestation_entities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_non_destructive_testing_id` BIGINT UNSIGNED NOT NULL,
    `attestation_entity` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `calculation_documentation_attestation_entity_unique_index`(`calculation_non_destructive_testing_id`, `attestation_entity`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_non_destructive_testing_surface_attestation_entities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_non_destructive_testing_id` BIGINT UNSIGNED NOT NULL,
    `attestation_entity` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `c_d_surface_attestation_entity_unique_index`(`calculation_non_destructive_testing_id`, `attestation_entity`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_non_destructive_testings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL,
    `calculation_id` BIGINT UNSIGNED NOT NULL,
    `non_destructive_testing_id` BIGINT UNSIGNED NOT NULL,
    `non_destructive_testing` VARCHAR(255) NOT NULL,
    `ultrasound_output` VARCHAR(255) NULL,
    `ultrasound_test_scope` VARCHAR(255) NULL,
    `ultrasound_test_range` VARCHAR(255) NULL,
    `ultrasound_efg_max` DOUBLE NULL,
    `ultrasound_attenuation` BOOLEAN NOT NULL DEFAULT false,
    `ultrasound_details` VARCHAR(255) NULL,
    `max_residual_field_strength` DOUBLE NULL,
    `max_residual_field_strength_unit` VARCHAR(255) NULL,
    `surface_crack_test_method` VARCHAR(255) NULL,
    `surface_crack_output` VARCHAR(255) NULL,
    `surface_crack_test_criteria` VARCHAR(255) NULL,
    `surface_crack_audit_scope` VARCHAR(255) NULL,
    `surface_crack_details` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `us_norm_id` BIGINT UNSIGNED NULL,
    `offer_note` VARCHAR(255) NULL,
    `surface_non_destructive_testing` VARCHAR(255) NULL,

    UNIQUE INDEX `calculation_non_destructive_testings_calculation_id_unique`(`calculation_id`),
    INDEX `calculation_non_destructive_testings_us_norm_id_foreign`(`us_norm_id`),
    INDEX `non_destructive_testing_id_foreign`(`non_destructive_testing_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_residual_materials` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_id` BIGINT UNSIGNED NOT NULL,
    `residual_material_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NULL,
    `specification` VARCHAR(255) NULL,
    `revision` VARCHAR(255) NULL,
    `quantity_sample_geometries` VARCHAR(255) NULL,
    `free_text` VARCHAR(255) NULL,
    `marking` VARCHAR(255) NULL,
    `frequency` VARCHAR(255) NULL,
    `cross_section_type` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `offer_note` VARCHAR(255) NULL,

    UNIQUE INDEX `calculation_residual_materials_calculation_id_unique`(`calculation_id`),
    INDEX `calculation_residual_materials_residual_material_id_foreign`(`residual_material_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_testing_scope_according_to_impact_tests` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_testing_scope_id` BIGINT UNSIGNED NOT NULL,
    `according_to_impact_test` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `calculation_testing_scope_id_index_unique`(`calculation_testing_scope_id`, `according_to_impact_test`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_testing_scope_according_to_tensile_tests` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_testing_scope_id` BIGINT UNSIGNED NOT NULL,
    `according_to_tensile_test` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `calculation_testing_scope_id_tensile_testsindex_unique`(`calculation_testing_scope_id`, `according_to_tensile_test`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_testing_scope_attestation_entities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_testing_scope_id` BIGINT UNSIGNED NOT NULL,
    `attestation_entity` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `calculation_testing_scope_id_index_entitiesunique`(`calculation_testing_scope_id`, `attestation_entity`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_testing_scope_classified_bies` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_testing_scope_id` BIGINT UNSIGNED NOT NULL,
    `classified_by` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `cts_melting_types_id_and_classified_by_unique`(`calculation_testing_scope_id`, `classified_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_testing_scope_melting_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_testing_scope_id` BIGINT UNSIGNED NOT NULL,
    `melting_type` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `calculation_testing_scope_melting_types_id_unique`(`calculation_testing_scope_id`, `melting_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_testing_scope_sample_depths` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `calculation_testing_scope_id` BIGINT UNSIGNED NOT NULL,
    `sample_depth` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `calculation_testing_scope_sample_depth_unique`(`calculation_testing_scope_id`, `sample_depth`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculation_testing_scopes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL,
    `calculation_id` BIGINT UNSIGNED NOT NULL,
    `testing_scope_id` BIGINT UNSIGNED NOT NULL,
    `issue_revision` VARCHAR(255) NOT NULL,
    `attestation` VARCHAR(255) NOT NULL,
    `frequency` VARCHAR(255) NOT NULL,
    `frequency_at_3_2` VARCHAR(255) NULL,
    `specimen_material` VARCHAR(255) NULL,
    `specimen_allowance` VARCHAR(255) NULL,
    `specimen_dimension` VARCHAR(255) NOT NULL,
    `bhp_dimension` VARCHAR(255) NULL,
    `specimen_rest_material` BOOLEAN NOT NULL DEFAULT false,
    `specimen_location` VARCHAR(255) NULL,
    `zug` DOUBLE NULL,
    `kbz` DOUBLE NULL,
    `tensile_test_external_testing` BOOLEAN NOT NULL DEFAULT false,
    `reh` DOUBLE NULL,
    `reh_min` DOUBLE NULL,
    `rp_1_0` DOUBLE NULL,
    `rm` DOUBLE NULL,
    `rm_min` DOUBLE NULL,
    `a5_min` DOUBLE NULL,
    `a4_min` DOUBLE NULL,
    `z_min` DOUBLE NULL,
    `rp_rm_ratio` DOUBLE NULL,
    `impact_test_external_testing` BOOLEAN NOT NULL DEFAULT false,
    `impact_test_typ` VARCHAR(255) NULL,
    `impact_test_temperature` DOUBLE NULL,
    `impact_test_details` VARCHAR(255) NULL,
    `tensile_test_details` VARCHAR(255) NULL,
    `tensile_test_warm_according_to` VARCHAR(255) NULL,
    `tensile_test_warm_external_testing` BOOLEAN NOT NULL DEFAULT false,
    `tensile_test_warm_details` VARCHAR(255) NULL,
    `hardness_test_location` VARCHAR(255) NULL,
    `max_hbw_on_the_component` DOUBLE NULL,
    `min_hbw_on_the_component` DOUBLE NULL,
    `max_hbw_on_sample` DOUBLE NULL,
    `min_hbw_on_sample` DOUBLE NULL,
    `hardness_test_details` VARCHAR(255) NULL,
    `hardness_test_type` VARCHAR(255) NULL,
    `hardness_details` VARCHAR(255) NULL,
    `jominy_test` BOOLEAN NOT NULL DEFAULT false,
    `jominy_details` VARCHAR(255) NULL,
    `further_testing` VARCHAR(255) NULL,
    `further_testing_external` BOOLEAN NOT NULL DEFAULT false,
    `kbz_0` DOUBLE NULL,
    `kbz_m_20` DOUBLE NULL,
    `kbz_m_50` DOUBLE NULL,
    `kbz_m_60` DOUBLE NULL,
    `zug_gt_40` DOUBLE NULL,
    `zug_300` DOUBLE NULL,
    `test_fold_and_bending` BOOLEAN NOT NULL DEFAULT false,
    `test_blue_structure` BOOLEAN NOT NULL DEFAULT false,
    `test_baumann_imprint` BOOLEAN NOT NULL DEFAULT false,
    `test_pin` BOOLEAN NOT NULL DEFAULT false,
    `test_us_calibration` BOOLEAN NOT NULL DEFAULT false,
    `toughness` DOUBLE NULL,
    `lateral_expansion` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `quantity_testing_pieces` INTEGER NULL,
    `offer_note` VARCHAR(255) NULL,
    `mq_quality` VARCHAR(255) NULL,
    `me_quality` VARCHAR(255) NULL,
    `is_classified_steel_plant` BOOLEAN NOT NULL DEFAULT false,
    `is_eu_material` BOOLEAN NOT NULL DEFAULT false,
    `attestation_following_regulation` BOOLEAN NOT NULL DEFAULT false,
    `temperature_wzv` INTEGER NULL,
    `impact_energy_av` DOUBLE NULL,
    `setpoint_hot_tensile_test` DOUBLE NULL,
    `max_sample_depth` VARCHAR(255) NULL,
    `buffer_90_mm` BOOLEAN NOT NULL DEFAULT false,
    `lotweight` INTEGER NULL,
    `max_lotsize` INTEGER NULL,
    `max_ht_weight_lot_testing` INTEGER NULL,
    `bhp_info` VARCHAR(255) NULL,

    UNIQUE INDEX `calculation_testing_scopes_calculation_id_unique`(`calculation_id`),
    INDEX `calculation_testing_scopes_testing_scope_id_foreign`(`testing_scope_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calculations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `offer_pos_id` BIGINT UNSIGNED NOT NULL,
    `operation_plan_id` BIGINT UNSIGNED NULL,
    `bom_id` BIGINT UNSIGNED NULL,
    `revision` VARCHAR(255) NULL,
    `specification_note` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `documentation_id` BIGINT UNSIGNED NULL,
    `residual_material_id` BIGINT UNSIGNED NULL,
    `metallography_id` BIGINT UNSIGNED NULL,
    `testing_scope_id` BIGINT UNSIGNED NULL,
    `non_destructive_testing_id` BIGINT UNSIGNED NULL,
    `sales_order` VARCHAR(255) NULL,
    `sales_order_pos` VARCHAR(255) NULL,
    `specification_id` BIGINT UNSIGNED NULL,
    `strength_span_min` DOUBLE NULL,
    `strength_span_max` DOUBLE NULL,
    `max_hardness` DOUBLE NULL,
    `min_hardness` DOUBLE NULL,
    `charge` BOOLEAN NOT NULL DEFAULT false,
    `melting_process` BOOLEAN NOT NULL DEFAULT false,
    `cleanliness_of_the_charge` BOOLEAN NOT NULL DEFAULT false,
    `grainsize_of_the_charge` BOOLEAN NOT NULL DEFAULT false,
    `jominy` BOOLEAN NOT NULL DEFAULT false,
    `heattreamtment` BOOLEAN NOT NULL DEFAULT false,
    `heattreamtment_with_diagram` BOOLEAN NOT NULL DEFAULT false,
    `pmi` BOOLEAN NOT NULL DEFAULT false,
    `hardness_testing_hbw` BOOLEAN NOT NULL DEFAULT false,
    `hardness_testing_hbw_per_piece` BOOLEAN NOT NULL DEFAULT false,
    `conversion_acc_iso_18265_table_a_1` BOOLEAN NOT NULL DEFAULT false,
    `conversion_acc_iso_18265_table_b_2` BOOLEAN NOT NULL DEFAULT false,
    `visual_inspection` BOOLEAN NOT NULL DEFAULT false,
    `indication_of_the_surface_condition` BOOLEAN NOT NULL DEFAULT false,
    `dimension_control` BOOLEAN NOT NULL DEFAULT false,
    `dimension_protocol` BOOLEAN NOT NULL DEFAULT false,
    `residual_magnetic_field_strength` BOOLEAN NOT NULL DEFAULT false,
    `radioactivity_freedom_confirmation` BOOLEAN NOT NULL DEFAULT false,
    `get_approval_from_the_client` BOOLEAN NOT NULL DEFAULT false,
    `concentricity_check` BOOLEAN NOT NULL DEFAULT false,
    `internal_note` VARCHAR(255) NULL,
    `price` DOUBLE NULL,
    `lead_time_days` DOUBLE NULL,
    `text` TEXT NULL,
    `text2` TEXT NULL,
    `text3` TEXT NULL,
    `text4` TEXT NULL,
    `delivery_weight` DOUBLE NULL,
    `hardenability_range_id` BIGINT UNSIGNED NULL,
    `deformation_id` BIGINT UNSIGNED NULL,
    `material_analysis_id` BIGINT UNSIGNED NULL,
    `non_destructive_testing_individual_id` BIGINT UNSIGNED NULL,
    `deformation_individual_id` BIGINT UNSIGNED NULL,
    `specify_deformation` BOOLEAN NOT NULL DEFAULT false,
    `hwe_work_plan_id` BIGINT UNSIGNED NULL,
    `note_machining` VARCHAR(255) NULL,
    `note_linked_operations` VARCHAR(255) NULL,
    `delivery_interval` INTEGER NULL,
    `text_final_dimension` VARCHAR(255) NULL,
    `text_raw_dimension` VARCHAR(255) NULL,
    `price_note` VARCHAR(255) NULL,
    `is_material_in_stock` BOOLEAN NULL,

    INDEX `calculations_bom_id_foreign`(`bom_id`),
    INDEX `calculations_deformation_id_foreign`(`deformation_id`),
    INDEX `calculations_deformation_individual_id_foreign`(`deformation_individual_id`),
    INDEX `calculations_documentation_id_foreign`(`documentation_id`),
    INDEX `calculations_hardenability_range_id_foreign`(`hardenability_range_id`),
    INDEX `calculations_hwe_work_plan_id_foreign`(`hwe_work_plan_id`),
    INDEX `calculations_material_analysis_id_foreign`(`material_analysis_id`),
    INDEX `calculations_metallography_id_foreign`(`metallography_id`),
    INDEX `calculations_non_destructive_testing_id_foreign`(`non_destructive_testing_id`),
    INDEX `calculations_non_destructive_testing_individual_id_foreign`(`non_destructive_testing_individual_id`),
    INDEX `calculations_offer_pos_id_foreign`(`offer_pos_id`),
    INDEX `calculations_operation_plan_id_foreign`(`operation_plan_id`),
    INDEX `calculations_residual_material_id_foreign`(`residual_material_id`),
    INDEX `calculations_specification_id_foreign`(`specification_id`),
    INDEX `calculations_testing_scope_id_foreign`(`testing_scope_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calibration_standards` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `calibration_standards_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `call_off_simulations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `call_off_simulations_name_unique`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `call_offs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `operation_plan_id` BIGINT UNSIGNED NULL,
    `order_id_customer` VARCHAR(255) NULL,
    `date` DATE NOT NULL,
    `quantity` DOUBLE NOT NULL,
    `is_internal` BOOLEAN NOT NULL DEFAULT false,
    `is_closed` BOOLEAN NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `call_offs_custom_id_unique`(`custom_id`),
    INDEX `call_offs_item_id_foreign`(`item_id`),
    INDEX `call_offs_operation_plan_id_foreign`(`operation_plan_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `capacities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `date` DATE NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `capacitable_type` VARCHAR(255) NOT NULL,
    `capacitable_id` BIGINT UNSIGNED NOT NULL,
    `shift_id` BIGINT UNSIGNED NULL,
    `start_time` TIME(0) NOT NULL,
    `end_time` TIME(0) NOT NULL,
    `break_minutes` INTEGER NOT NULL,
    `date_to_consider` VARCHAR(255) NOT NULL DEFAULT 'SHIFT_START',

    INDEX `capacities_capacitable_type_capacitable_id_index`(`capacitable_type`, `capacitable_id`),
    INDEX `capacities_shift_id_foreign`(`shift_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `chat_user` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `chat_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `chat_user_chat_id_foreign`(`chat_id`),
    INDEX `chat_user_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `chats` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL,
    `is_group_chat` BOOLEAN NOT NULL DEFAULT false,
    `is_managed_chat` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `associated_module` VARCHAR(255) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `chem_analyses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `min` DOUBLE NULL,
    `max` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `unit` VARCHAR(255) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `classifications` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `model_type` VARCHAR(255) NOT NULL,
    `model_id` BIGINT UNSIGNED NOT NULL,
    `class` VARCHAR(255) NOT NULL,
    `attribute` VARCHAR(255) NOT NULL,
    `value_string` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `value_double` DOUBLE NULL,

    INDEX `classifications_model_type_model_id_index`(`model_type`, `model_id`),
    UNIQUE INDEX `classifications_model_type_model_id_class_attribute_unique`(`model_type`, `model_id`, `class`, `attribute`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `command_schedules` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `command` VARCHAR(255) NOT NULL,
    `priority` INTEGER NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `cron_expression` VARCHAR(255) NOT NULL,
    `last_run_at` DATETIME(0) NULL,
    `last_output` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `command_schedules_command_unique`(`command`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `component_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `has_permission` BOOLEAN NOT NULL,
    `is_enabled` BOOLEAN NOT NULL,
    `component_type` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contact_person_task` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `task_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `contact_person_task_task_id_foreign`(`task_id`),
    INDEX `contact_person_task_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contactable_contacts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `contactable_type` VARCHAR(255) NOT NULL,
    `contactable_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `contactable_contacts_contact_id_foreign`(`contact_id`),
    INDEX `contactable_contacts_contactable_type_contactable_id_index`(`contactable_type`, `contactable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contacts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NULL,
    `first_name` VARCHAR(255) NULL,
    `last_name` VARCHAR(255) NULL,
    `email` VARCHAR(255) NULL,
    `telephone` VARCHAR(255) NULL,
    `mobile` VARCHAR(255) NULL,
    `role_description` VARCHAR(255) NULL,
    `xing` VARCHAR(255) NULL,
    `linkedin` VARCHAR(255) NULL,
    `note` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_main_addressee` BOOLEAN NOT NULL DEFAULT false,
    `salutation` VARCHAR(255) NULL,
    `dept_name` VARCHAR(255) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cost_center_costs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `cost_center_id` BIGINT UNSIGNED NULL,
    `cost` DOUBLE NOT NULL DEFAULT 0,
    `cost_type` VARCHAR(255) NULL,
    `valid_from` DATE NULL,
    `valid_to` DATE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `cost_center_costs_cost_center_id_foreign`(`cost_center_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cost_centers` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `cost_centers_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `countries` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `is_active` BOOLEAN NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `crm_id` VARCHAR(255) NULL,
    `hwe_freight_surplus` DOUBLE NOT NULL DEFAULT 0,
    `hwe_overhead_surplus` DOUBLE NOT NULL DEFAULT 0,
    `lead_time_days` DOUBLE NOT NULL DEFAULT 5,

    UNIQUE INDEX `countries_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `crm_actions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(100) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sort_order` INTEGER NOT NULL DEFAULT 0,
    `goal` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `crm_actions_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `crm_customer_plants` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `location` VARCHAR(255) NULL,
    `country_id` BIGINT UNSIGNED NULL,
    `customer_id` BIGINT UNSIGNED NULL,
    `is_head_office` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `crm_customer_plants_custom_id_unique`(`custom_id`),
    INDEX `crm_customer_plants_country_id_foreign`(`country_id`),
    INDEX `crm_customer_plants_customer_id_foreign`(`customer_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `crm_priorities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL,
    `custom_id` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `sort_order` INTEGER NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `crm_priorities_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `crucibles` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `capacity` INTEGER NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `crucibles_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customer_categories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL,
    `custom_id` VARCHAR(255) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sort_order` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `customer_categories_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customer_crm_action_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `customer_id` BIGINT UNSIGNED NOT NULL,
    `crm_action_id` BIGINT UNSIGNED NOT NULL,
    `log_date` DATETIME(0) NOT NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `note` TEXT NULL,
    `contact_id` BIGINT UNSIGNED NULL,
    `sales_status_id` BIGINT UNSIGNED NULL,
    `crm_priority_id` BIGINT UNSIGNED NULL,
    `date_follow_up` DATE NULL,

    INDEX `customer_crm_action_logs_contact_id_foreign`(`contact_id`),
    INDEX `customer_crm_action_logs_crm_action_id_foreign`(`crm_action_id`),
    INDEX `customer_crm_action_logs_crm_priority_id_foreign`(`crm_priority_id`),
    INDEX `customer_crm_action_logs_customer_id_foreign`(`customer_id`),
    INDEX `customer_crm_action_logs_sales_status_id_foreign`(`sales_status_id`),
    INDEX `customer_crm_action_logs_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customer_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `is_active` BOOLEAN NULL DEFAULT true,
    `crm_id` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `sort_order` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `customer_groups_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customer_items` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `customer_id` BIGINT UNSIGNED NOT NULL,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `customer_items_item_id_foreign`(`item_id`),
    UNIQUE INDEX `customer_items_customer_id_item_id_unique`(`customer_id`, `item_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customer_market_segments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `customer_id` BIGINT UNSIGNED NOT NULL,
    `market_segment_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `customer_market_segments_customer_id_foreign`(`customer_id`),
    INDEX `customer_market_segments_market_segment_id_foreign`(`market_segment_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customer_tasks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `customer_id` BIGINT UNSIGNED NOT NULL,
    `task_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `customer_tasks_customer_id_foreign`(`customer_id`),
    INDEX `customer_tasks_task_id_foreign`(`task_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customers` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_active` TINYINT NOT NULL DEFAULT 0,
    `crm_id` VARCHAR(255) NULL,
    `name2` VARCHAR(255) NULL,
    `name3` VARCHAR(255) NULL,
    `address` VARCHAR(255) NULL,
    `postal_code` VARCHAR(255) NULL,
    `city` VARCHAR(255) NULL,
    `country_id` BIGINT UNSIGNED NULL,
    `telephone` VARCHAR(255) NULL,
    `vat` VARCHAR(255) NULL,
    `total_insured` DOUBLE NULL,
    `total_production` DOUBLE NULL,
    `total_outstanding` DOUBLE NULL,
    `total_revenue` DOUBLE NULL,
    `delivery_term_id` BIGINT UNSIGNED NULL,
    `payment_term_id` BIGINT UNSIGNED NULL,
    `sales_area_id` BIGINT UNSIGNED NULL,
    `sales_group_id` BIGINT UNSIGNED NULL,
    `sector_id` BIGINT UNSIGNED NULL,
    `customer_group_id` BIGINT UNSIGNED NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `email` VARCHAR(255) NULL,
    `website` MEDIUMTEXT NULL,
    `date_follow_up` DATE NULL,
    `revenue_classification_id` BIGINT UNSIGNED NULL,
    `machine_classification_id` BIGINT UNSIGNED NULL,
    `employee_classification_id` BIGINT UNSIGNED NULL,
    `potential_classification_id` BIGINT UNSIGNED NULL,
    `sales_status_id` BIGINT UNSIGNED NULL,
    `chat_id` BIGINT UNSIGNED NULL,
    `user_id_responsible` BIGINT UNSIGNED NULL,
    `market_segment_id` BIGINT UNSIGNED NULL,
    `external_id` VARCHAR(255) NULL,
    `source` VARCHAR(255) NULL,
    `date_sourced` DATE NULL,
    `note` LONGTEXT NULL,
    `progress` DOUBLE NULL DEFAULT 0,
    `region` VARCHAR(255) NULL,
    `customer_category_id` BIGINT UNSIGNED NULL,
    `country_code` VARCHAR(255) NULL,
    `linkeldn` TEXT NULL,
    `wz_codes` VARCHAR(255) NULL,
    `branch_1` VARCHAR(255) NULL,
    `branch_2` VARCHAR(255) NULL,
    `crm_priority_id` BIGINT UNSIGNED NULL,
    `customer_id_head_office` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `customers_custom_id_unique`(`custom_id`),
    INDEX `customers_chat_id_foreign`(`chat_id`),
    INDEX `customers_country_id_foreign`(`country_id`),
    INDEX `customers_crm_priority_id_foreign`(`crm_priority_id`),
    INDEX `customers_customer_category_id_foreign`(`customer_category_id`),
    INDEX `customers_customer_group_id_foreign`(`customer_group_id`),
    INDEX `customers_customer_id_head_office_foreign`(`customer_id_head_office`),
    INDEX `customers_delivery_term_id_foreign`(`delivery_term_id`),
    INDEX `customers_employee_classification_id_foreign`(`employee_classification_id`),
    INDEX `customers_machine_classification_id_foreign`(`machine_classification_id`),
    INDEX `customers_market_segment_id_foreign`(`market_segment_id`),
    INDEX `customers_payment_term_id_foreign`(`payment_term_id`),
    INDEX `customers_potential_classification_id_foreign`(`potential_classification_id`),
    INDEX `customers_revenue_classification_id_foreign`(`revenue_classification_id`),
    INDEX `customers_sales_area_id_foreign`(`sales_area_id`),
    INDEX `customers_sales_group_id_foreign`(`sales_group_id`),
    INDEX `customers_sales_status_id_foreign`(`sales_status_id`),
    INDEX `customers_sector_id_foreign`(`sector_id`),
    INDEX `customers_user_id_responsible_foreign`(`user_id_responsible`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customers_20250716` (
    `id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_active` TINYINT NOT NULL DEFAULT 0,
    `crm_id` VARCHAR(255) NULL,
    `name2` VARCHAR(255) NULL,
    `name3` VARCHAR(255) NULL,
    `address` VARCHAR(255) NULL,
    `postal_code` VARCHAR(255) NULL,
    `city` VARCHAR(255) NULL,
    `country_id` BIGINT UNSIGNED NULL,
    `telephone` VARCHAR(255) NULL,
    `vat` VARCHAR(255) NULL,
    `total_insured` DOUBLE NULL,
    `total_production` DOUBLE NULL,
    `total_outstanding` DOUBLE NULL,
    `total_revenue` DOUBLE NULL,
    `delivery_term_id` BIGINT UNSIGNED NULL,
    `payment_term_id` BIGINT UNSIGNED NULL,
    `sales_area_id` BIGINT UNSIGNED NULL,
    `sales_group_id` BIGINT UNSIGNED NULL,
    `sector_id` BIGINT UNSIGNED NULL,
    `customer_group_id` BIGINT UNSIGNED NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `email` VARCHAR(255) NULL,
    `website` MEDIUMTEXT NULL,
    `date_follow_up` DATE NULL,
    `revenue_classification_id` BIGINT UNSIGNED NULL,
    `machine_classification_id` BIGINT UNSIGNED NULL,
    `employee_classification_id` BIGINT UNSIGNED NULL,
    `potential_classification_id` BIGINT UNSIGNED NULL,
    `sales_status_id` BIGINT UNSIGNED NULL,
    `chat_id` BIGINT UNSIGNED NULL,
    `user_id_responsible` BIGINT UNSIGNED NULL,
    `market_segment_id` BIGINT UNSIGNED NULL,
    `external_id` VARCHAR(255) NULL,
    `source` VARCHAR(255) NULL,
    `date_sourced` DATE NULL,
    `note` LONGTEXT NULL,
    `progress` DOUBLE NULL DEFAULT 0,
    `region` VARCHAR(255) NULL,
    `customer_category_id` BIGINT UNSIGNED NULL,
    `country_code` VARCHAR(255) NULL,
    `linkeldn` TEXT NULL,
    `wz_codes` VARCHAR(255) NULL,
    `branch_1` VARCHAR(255) NULL,
    `branch_2` VARCHAR(255) NULL,
    `crm_priority_id` BIGINT UNSIGNED NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customers_bkp` (
    `id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_active` TINYINT NOT NULL DEFAULT 0,
    `crm_id` VARCHAR(255) NULL,
    `name2` VARCHAR(255) NULL,
    `name3` VARCHAR(255) NULL,
    `address` VARCHAR(255) NULL,
    `postal_code` VARCHAR(255) NULL,
    `city` VARCHAR(255) NULL,
    `country_id` BIGINT UNSIGNED NULL,
    `telephone` VARCHAR(255) NULL,
    `vat` VARCHAR(255) NULL,
    `total_insured` DOUBLE NULL,
    `total_production` DOUBLE NULL,
    `total_outstanding` DOUBLE NULL,
    `total_revenue` DOUBLE NULL,
    `delivery_term_id` BIGINT UNSIGNED NULL,
    `payment_term_id` BIGINT UNSIGNED NULL,
    `sales_area_id` BIGINT UNSIGNED NULL,
    `sales_group_id` BIGINT UNSIGNED NULL,
    `sector_id` BIGINT UNSIGNED NULL,
    `customer_group_id` BIGINT UNSIGNED NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `email` VARCHAR(255) NULL,
    `website` MEDIUMTEXT NULL,
    `date_follow_up` DATE NULL,
    `revenue_classification_id` BIGINT UNSIGNED NULL,
    `machine_classification_id` BIGINT UNSIGNED NULL,
    `employee_classification_id` BIGINT UNSIGNED NULL,
    `potential_classification_id` BIGINT UNSIGNED NULL,
    `sales_status_id` BIGINT UNSIGNED NULL,
    `chat_id` BIGINT UNSIGNED NULL,
    `user_id_responsible` BIGINT UNSIGNED NULL,
    `market_segment_id` BIGINT UNSIGNED NULL,
    `external_id` VARCHAR(255) NULL,
    `source` VARCHAR(255) NULL,
    `date_sourced` DATE NULL,
    `note` LONGTEXT NULL,
    `progress` DOUBLE NULL DEFAULT 0,
    `region` VARCHAR(255) NULL,
    `customer_category_id` BIGINT UNSIGNED NULL,
    `country_code` VARCHAR(255) NULL,
    `linkeldn` TEXT NULL,
    `wz_codes` VARCHAR(255) NULL,
    `branch_1` VARCHAR(255) NULL,
    `branch_2` VARCHAR(255) NULL,
    `crm_priority_id` BIGINT UNSIGNED NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `data_exports` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `data` TEXT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_exported` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `result_message` TEXT NULL,
    `is_exporting` BOOLEAN NOT NULL DEFAULT false,
    `last_exported_at` TIMESTAMP(0) NULL,
    `http_method` VARCHAR(255) NULL,
    `http_url` VARCHAR(255) NULL,
    `http_payload` TEXT NULL,
    `retry_count` INTEGER NULL DEFAULT 0,

    INDEX `data_export_is_exported_index`(`is_exported`),
    INDEX `data_export_name_index`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `data_imports` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `data` LONGTEXT NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_imported` TINYINT NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_importing` BOOLEAN NOT NULL DEFAULT false,
    `last_imported_at` DATETIME(0) NULL,

    INDEX `data_import_is_imported_index`(`is_imported`),
    INDEX `data_import_name_index`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `deformations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `continuous_casting` VARCHAR(255) NULL,
    `ingot_casting` VARCHAR(255) NULL,
    `stretch_forging_degree` VARCHAR(255) NULL,
    `note` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deformation` DOUBLE NULL,

    UNIQUE INDEX `deformations_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `delivery_terms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `is_active` BOOLEAN NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `crm_id` VARCHAR(255) NULL,
    `has_delivery_cost` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `delivery_terms_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `department_hall` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `department_id` BIGINT UNSIGNED NOT NULL,
    `hall_id` BIGINT UNSIGNED NOT NULL,

    INDEX `department_hall_hall_id_foreign`(`hall_id`),
    UNIQUE INDEX `department_hall_department_id_hall_id_unique`(`department_id`, `hall_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `departments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `departments_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `directory_structures` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `custom_id` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sectionable_type` VARCHAR(255) NULL,
    `sectionable_id` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `directory_structures_custom_id_unique`(`custom_id`),
    INDEX `directory_structures_sectionable_type_sectionable_id_index`(`sectionable_type`, `sectionable_id`),
    UNIQUE INDEX `directory_structures_name_sectionable_id_sectionable_type_unique`(`name`, `sectionable_id`, `sectionable_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `doc_visu_directories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NULL,
    `name` VARCHAR(255) NOT NULL,
    `parent_type` VARCHAR(255) NOT NULL,
    `parent_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `doc_visu_directories_parent_type_parent_id_index`(`parent_type`, `parent_id`),
    UNIQUE INDEX `doc_visu_directories_custom_id_name_parent_id_parent_type_unique`(`custom_id`, `name`, `parent_id`, `parent_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `doc_visu_directory_versions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `version` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `doc_visu_directory_id` BIGINT UNSIGNED NOT NULL,
    `user_id_creator` BIGINT UNSIGNED NULL,
    `type` VARCHAR(255) NOT NULL DEFAULT 'CREATED',
    `updated_name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `doc_visu_directory_versions_doc_visu_directory_id_foreign`(`doc_visu_directory_id`),
    INDEX `doc_visu_directory_versions_user_id_creator_foreign`(`user_id_creator`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `doc_visu_files` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `parent_type` VARCHAR(255) NOT NULL,
    `parent_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_trainable` BOOLEAN NOT NULL DEFAULT true,
    `is_releasable` BOOLEAN NOT NULL DEFAULT false,
    `is_released` BOOLEAN NOT NULL DEFAULT false,
    `user_id_released_by` BIGINT UNSIGNED NULL,
    `released_date` TIMESTAMP(0) NULL,

    UNIQUE INDEX `doc_visu_files_custom_id_unique`(`custom_id`),
    INDEX `doc_visu_files_parent_type_parent_id_index`(`parent_type`, `parent_id`),
    INDEX `doc_visu_files_user_id_released_by_foreign`(`user_id_released_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `doc_visu_linkings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent_type` VARCHAR(255) NOT NULL,
    `parent_id` BIGINT UNSIGNED NOT NULL,
    `linkable_type` VARCHAR(255) NOT NULL,
    `linkable_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `doc_visu_linkings_linkable_type_linkable_id_index`(`linkable_type`, `linkable_id`),
    INDEX `doc_visu_linkings_parent_type_parent_id_index`(`parent_type`, `parent_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `document_sections` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `custom_id` VARCHAR(255) NOT NULL,
    `directory_structure_id` BIGINT UNSIGNED NULL,
    `model_type` VARCHAR(255) NULL,
    `sort_order` INTEGER NOT NULL DEFAULT 0,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `document_sections_custom_id_unique`(`custom_id`),
    INDEX `document_sections_directory_structure_id_foreign`(`directory_structure_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `documentation_certificates` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `documentation_id` BIGINT UNSIGNED NOT NULL,
    `certificate` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `documentation_certificates_documentation_id_certificate_index`(`documentation_id`, `certificate`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `documentations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `charge` BOOLEAN NOT NULL DEFAULT false,
    `melting_process` BOOLEAN NOT NULL DEFAULT false,
    `cleanliness_of_the_charge` BOOLEAN NOT NULL DEFAULT false,
    `cleanliness_of_the_component` BOOLEAN NOT NULL DEFAULT false,
    `grainsize_of_the_charge` BOOLEAN NOT NULL DEFAULT false,
    `grainsize_of_the_component` BOOLEAN NOT NULL DEFAULT false,
    `product_analysis` BOOLEAN NOT NULL DEFAULT false,
    `jominy` BOOLEAN NOT NULL DEFAULT false,
    `heattreamtment` BOOLEAN NOT NULL DEFAULT false,
    `heattreamtment_with_diagram` BOOLEAN NOT NULL DEFAULT false,
    `deformation` BOOLEAN NOT NULL DEFAULT false,
    `hardness_testing_hbw` BOOLEAN NOT NULL DEFAULT false,
    `hardness_testing_hbw_per_piece` BOOLEAN NOT NULL DEFAULT false,
    `conversion_acc_iso_18265_table_a_1` BOOLEAN NOT NULL DEFAULT false,
    `conversion_acc_iso_18265_table_b_2` BOOLEAN NOT NULL DEFAULT false,
    `pmi` BOOLEAN NOT NULL DEFAULT false,
    `visual_inspection` BOOLEAN NOT NULL DEFAULT false,
    `indication_of_the_surface_condition` BOOLEAN NOT NULL DEFAULT false,
    `dimension_control` BOOLEAN NOT NULL DEFAULT false,
    `dimension_protocol` BOOLEAN NOT NULL DEFAULT false,
    `residual_magnetic_field_strength` BOOLEAN NOT NULL DEFAULT false,
    `radioactivity_freedom_confirmation` BOOLEAN NOT NULL DEFAULT false,
    `confirmation_of_the_absence_of_flakes` BOOLEAN NOT NULL DEFAULT false,
    `create_forging_schedule` BOOLEAN NOT NULL DEFAULT false,
    `create_specimen_plan` BOOLEAN NOT NULL DEFAULT false,
    `create_us_test_instruction` BOOLEAN NOT NULL DEFAULT false,
    `create_mpe_test_instruction` BOOLEAN NOT NULL DEFAULT false,
    `create_fe_test_instruction` BOOLEAN NOT NULL DEFAULT false,
    `create_manufacturing_plan` BOOLEAN NOT NULL DEFAULT false,
    `create_heat_treatment_plan` BOOLEAN NOT NULL DEFAULT false,
    `test_sequence_plan` BOOLEAN NOT NULL DEFAULT false,
    `get_approval_from_the_client` BOOLEAN NOT NULL DEFAULT false,
    `initial_inspection` BOOLEAN NOT NULL DEFAULT false,
    `concentricity_check` BOOLEAN NOT NULL DEFAULT false,
    `create_furnace_position_plan` BOOLEAN NOT NULL DEFAULT false,
    `text` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `regulation` VARCHAR(255) NOT NULL,
    `issue_revision` VARCHAR(255) NOT NULL,
    `check_machine_feasibility` BOOLEAN NOT NULL DEFAULT false,
    `check_ik` BOOLEAN NOT NULL DEFAULT false,
    `offer_note` VARCHAR(255) NULL,
    `marking` VARCHAR(255) NULL,
    `acceptance` BOOLEAN NOT NULL DEFAULT false,
    `fpp_nr` VARCHAR(255) NULL,
    `fpp_rev` VARCHAR(255) NULL,
    `process_route` VARCHAR(255) NULL,

    UNIQUE INDEX `documentations_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `eight_d_report_actions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `eight_d_report_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NULL,
    `action_type` VARCHAR(255) NULL,
    `description` TEXT NULL,
    `responsible_id` BIGINT UNSIGNED NULL,
    `end_date` DATETIME(0) NULL,
    `progress` INTEGER NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `show_on_report` BOOLEAN NOT NULL DEFAULT true,

    INDEX `eight_d_report_actions_eight_d_report_id_foreign`(`eight_d_report_id`),
    INDEX `eight_d_report_actions_responsible_id_foreign`(`responsible_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `eight_d_report_five_whies` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `eight_d_report_id` BIGINT UNSIGNED NOT NULL,
    `question` VARCHAR(255) NULL,
    `answer` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `eight_d_report_five_whies_eight_d_report_id_foreign`(`eight_d_report_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `eight_d_report_ishikawas` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `eight_d_report_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NULL,
    `category` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `eight_d_report_ishikawas_eight_d_report_id_foreign`(`eight_d_report_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `eight_d_report_teams` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `eight_d_report_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `eight_d_report_teams_user_id_foreign`(`user_id`),
    UNIQUE INDEX `eight_d_report_teams_eight_d_report_id_user_id_unique`(`eight_d_report_id`, `user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `eight_d_reports` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `complaint_no` VARCHAR(255) NULL,
    `supplier_id` BIGINT UNSIGNED NULL,
    `drawing_no` INTEGER NULL,
    `drawing_revision` VARCHAR(255) NULL,
    `plant_id` BIGINT UNSIGNED NULL,
    `quantity_delivered` INTEGER NULL,
    `part_name` VARCHAR(255) NULL,
    `complaint_opening_date` DATETIME(0) NULL,
    `revision` INTEGER NULL,
    `revision_date` DATETIME(0) NULL,
    `quantity_claimed` INTEGER NULL,
    `description` TEXT NULL,
    `author_accepted` BOOLEAN NULL,
    `author_id` BIGINT UNSIGNED NOT NULL,
    `author_closing_date` DATETIME(0) NULL,
    `client_accepted` BOOLEAN NULL,
    `client_closing_date` DATETIME(0) NULL,
    `chat_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `client_name` VARCHAR(255) NULL,
    `root_cause` TEXT NULL,
    `root_cause_type` VARCHAR(255) NULL,
    `report_type` VARCHAR(255) NULL DEFAULT 'DEFAULT',

    INDEX `eight_d_reports_author_id_foreign`(`author_id`),
    INDEX `eight_d_reports_chat_id_foreign`(`chat_id`),
    INDEX `eight_d_reports_plant_id_foreign`(`plant_id`),
    INDEX `eight_d_reports_supplier_id_foreign`(`supplier_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `employee_classifications` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sort_order` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `employee_classifications_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `energy_consumer_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `energy_consumer_groups_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `energy_consumer_machines` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `energy_consumer_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `energy_consumer_machines_energy_consumer_id_foreign`(`energy_consumer_id`),
    UNIQUE INDEX `energy_consumer_machines_unique_index`(`machine_id`, `energy_consumer_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `energy_consumers` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `energy_consumer_group_id` BIGINT UNSIGNED NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `energy_consumers_custom_id_unique`(`custom_id`),
    INDEX `energy_consumers_energy_consumer_group_id_foreign`(`energy_consumer_group_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `energy_consumptions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `date` DATE NOT NULL,
    `energy_consumer_id` BIGINT UNSIGNED NOT NULL,
    `energy_type` VARCHAR(255) NOT NULL DEFAULT 'GAS',
    `consumption_hour` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `energy_consumption` DOUBLE NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `energy_consumptions_energy_consumer_id_foreign`(`energy_consumer_id`),
    UNIQUE INDEX `alternative_unique_index`(`date`, `energy_consumer_id`, `consumption_hour`, `energy_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `energy_gateways` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `ip_address` VARCHAR(255) NOT NULL,
    `port` INTEGER NOT NULL,
    `gateway_type` VARCHAR(255) NOT NULL DEFAULT 'ADVANTECH',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `energy_gateways_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `energy_impeller_consumptions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `date` DATE NOT NULL,
    `energy_consumer_id` BIGINT UNSIGNED NOT NULL,
    `energy_type` VARCHAR(255) NOT NULL DEFAULT 'GAS',
    `hour_of_day` INTEGER NOT NULL,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `alloy_name` VARCHAR(255) NOT NULL,
    `material_consumption` DOUBLE NOT NULL,
    `energy_consumption` DOUBLE NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `energy_impeller_consumptions_energy_consumer_id_foreign`(`energy_consumer_id`),
    INDEX `energy_impeller_consumptions_machine_id_foreign`(`machine_id`),
    UNIQUE INDEX `energy_impeller_consumptions_unique_index`(`date`, `energy_consumer_id`, `energy_type`, `hour_of_day`, `alloy_name`, `machine_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `energy_meter_readings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `energy_consumer_id` BIGINT UNSIGNED NOT NULL,
    `value` DOUBLE NOT NULL,
    `energy_type` VARCHAR(255) NOT NULL DEFAULT 'GAS',
    `energy_meter_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `energy_meter_readings_energy_consumer_id_foreign`(`energy_consumer_id`),
    INDEX `energy_meter_readings_energy_meter_id_foreign`(`energy_meter_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `energy_meters` (
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `energy_consumer_id` BIGINT UNSIGNED NOT NULL,
    `energy_type` VARCHAR(255) NOT NULL DEFAULT 'GAS',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,

    INDEX `energy_meters_energy_consumer_id_foreign`(`energy_consumer_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `equipment` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NULL,
    `item_id` BIGINT UNSIGNED NULL,
    `serial` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `equipment_id_parent` BIGINT UNSIGNED NULL,
    `validity_end` DATETIME(0) NULL,
    `name` VARCHAR(255) NULL,
    `is_transport_possible` BOOLEAN NOT NULL DEFAULT true,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `validity` DATETIME(0) NULL,
    `cycle_counter` INTEGER NOT NULL DEFAULT 0,
    `equipment_status_id` BIGINT UNSIGNED NULL,
    `decimals` INTEGER NULL,
    `calibration_standard_id` BIGINT UNSIGNED NULL,
    `value_lower_limit` DECIMAL(8, 2) NULL,
    `value_upper_limit` DECIMAL(8, 2) NULL,
    `calibration_interval` INTEGER NULL,
    `last_calibration_date` DATETIME(0) NULL,
    `customer_id` BIGINT UNSIGNED NULL,
    `storage_bin_id` BIGINT UNSIGNED NULL,
    `storage_bin_id_gripper` BIGINT UNSIGNED NULL,
    `guaranteed_cycles` BIGINT NULL,
    `imported_cycles` BIGINT NULL,
    `total_cycles` BIGINT NULL,
    `cavity` INTEGER NULL,
    `note` VARCHAR(255) NULL,
    `note_2` VARCHAR(255) NULL,
    `height` DOUBLE NULL,
    `width` DOUBLE NULL,
    `length` DOUBLE NULL,
    `project_reference` VARCHAR(255) NULL,
    `customer_reference` VARCHAR(255) NULL,
    `weight` DOUBLE NULL,
    `weight_2` DOUBLE NULL,
    `weight_3` DOUBLE NULL,
    `production_year` INTEGER NULL,
    `last_year_date_stamp` INTEGER NULL,
    `centering_ring` VARCHAR(255) NULL,
    `thread_ejector` VARCHAR(255) NULL,
    `item_id_date_stamp` BIGINT UNSIGNED NULL,
    `item_id_spare_year_change` BIGINT UNSIGNED NULL,
    `brand_date_stamp` VARCHAR(255) NULL,
    `diameter_date_stamp` DOUBLE NULL,

    UNIQUE INDEX `equipment_custom_id_unique`(`custom_id`),
    INDEX `equipment_calibration_standard_id_foreign`(`calibration_standard_id`),
    INDEX `equipment_customer_id_foreign`(`customer_id`),
    INDEX `equipment_equipment_id_parent_foreign`(`equipment_id_parent`),
    INDEX `equipment_equipment_status_id_foreign`(`equipment_status_id`),
    INDEX `equipment_item_id_date_stamp_foreign`(`item_id_date_stamp`),
    INDEX `equipment_item_id_spare_year_change_foreign`(`item_id_spare_year_change`),
    INDEX `equipment_storage_bin_id_foreign`(`storage_bin_id`),
    INDEX `equipment_storage_bin_id_gripper_foreign`(`storage_bin_id_gripper`),
    UNIQUE INDEX `equipment_item_id_serial_unique`(`item_id`, `serial`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `equipment_equipment_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `equipment_id` BIGINT UNSIGNED NOT NULL,
    `equipment_group_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `equipment_equipment_groups_equipment_group_id_foreign`(`equipment_group_id`),
    INDEX `equipment_equipment_groups_equipment_id_foreign`(`equipment_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `equipment_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `equipment_groups_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `equipment_item` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `equipment_id` BIGINT UNSIGNED NOT NULL,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `equipment_item_equipment_id_foreign`(`equipment_id`),
    INDEX `equipment_item_item_id_foreign`(`item_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `equipment_machine` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `equipment_id` BIGINT UNSIGNED NOT NULL,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `equipment_machine_equipment_id_foreign`(`equipment_id`),
    INDEX `equipment_machine_machine_id_foreign`(`machine_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `equipment_statuses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `equipment_statuses_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `failed_jobs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(255) NOT NULL,
    `connection` TEXT NOT NULL,
    `queue` TEXT NOT NULL,
    `payload` LONGTEXT NOT NULL,
    `exception` LONGTEXT NOT NULL,
    `failed_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `favorites` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `favoritable_type` VARCHAR(255) NOT NULL,
    `favoritable_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `favorites_favoritable_type_favoritable_id_index`(`favoritable_type`, `favoritable_id`),
    UNIQUE INDEX `favoritable_unique_key`(`user_id`, `favoritable_id`, `favoritable_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fcm_tokens` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `token` VARCHAR(255) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `fcm_tokens_token_unique`(`token`),
    INDEX `fcm_tokens_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `file_notes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `note` TEXT NOT NULL,
    `doc_visu_file_id` BIGINT UNSIGNED NOT NULL,
    `user_id_creator` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `file_notes_doc_visu_file_id_foreign`(`doc_visu_file_id`),
    INDEX `file_notes_user_id_creator_foreign`(`user_id_creator`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `file_versions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `version` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `doc_visu_file_id` BIGINT UNSIGNED NOT NULL,
    `user_id_creator` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `type` VARCHAR(255) NOT NULL DEFAULT 'CREATED',
    `media_file_id` BIGINT UNSIGNED NULL,
    `updated_name` VARCHAR(255) NULL,

    INDEX `file_versions_doc_visu_file_id_foreign`(`doc_visu_file_id`),
    INDEX `file_versions_media_file_id_foreign`(`media_file_id`),
    INDEX `file_versions_user_id_creator_foreign`(`user_id_creator`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `grid_table_configs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `table_key` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `fields` LONGTEXT NOT NULL,

    UNIQUE INDEX `grid_table_config_tablekey_unique`(`table_key`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hall_capacity_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hall_id` BIGINT UNSIGNED NOT NULL,
    `date` DATE NOT NULL,
    `machine_usage` DOUBLE NOT NULL DEFAULT 1,
    `employee_usage` DOUBLE NOT NULL DEFAULT 1,
    `overtime_factor` DOUBLE NOT NULL DEFAULT 0,
    `distribution_factor` DOUBLE NOT NULL DEFAULT 0,
    `additional_hours` DOUBLE NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `hall_capacity_settings_hall_id_foreign`(`hall_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hall_shift_visu_issue_type` (
    `hall_id` BIGINT UNSIGNED NOT NULL,
    `shift_visu_issue_type_id` BIGINT UNSIGNED NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `halls` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_enabled_plan_visu` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `production_planning_page` VARCHAR(255) NOT NULL DEFAULT 'Default',
    `is_enabled_statusboard` BOOLEAN NOT NULL DEFAULT false,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `frozen_zone_before_days` INTEGER NULL,
    `frozen_zone_after_weeks` INTEGER NULL,

    UNIQUE INDEX `halls_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `handling_unit_prod_order_pos_operation_consumptions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `handling_unit_id` BIGINT UNSIGNED NOT NULL,
    `prod_order_pos_operation_consumption_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `h_u_prod_order_pos_operation_consumptions_p_o_p_o_c_foreign`(`prod_order_pos_operation_consumption_id`),
    INDEX `handling_unit_prod_order_pos_operation_consumptions_h_u_foreign`(`handling_unit_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `handling_units` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `item_id` BIGINT UNSIGNED NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_exported` BOOLEAN NOT NULL DEFAULT false,
    `packaging_instruction_id` BIGINT UNSIGNED NULL,
    `is_complete` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `handling_units_custom_id_unique`(`custom_id`),
    INDEX `handling_units_item_id_foreign`(`item_id`),
    INDEX `handling_units_packaging_instruction_id_foreign`(`packaging_instruction_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hardenability_range_material` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hardenability_range_id` BIGINT UNSIGNED NOT NULL,
    `material_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `ham_harden_ability_range_id_foreign`(`hardenability_range_id`),
    INDEX `ham_material_id_foreign`(`material_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hardenability_ranges` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `with_applicable_standard` VARCHAR(255) NULL,
    `note` VARCHAR(255) NULL,
    `jominy_batch` VARCHAR(255) NULL,
    `value_1_5_min` DOUBLE NULL,
    `value_1_5_max` DOUBLE NULL,
    `value_3_min` DOUBLE NULL,
    `value_3_max` DOUBLE NULL,
    `value_5_min` DOUBLE NULL,
    `value_5_max` DOUBLE NULL,
    `value_7_min` DOUBLE NULL,
    `value_7_max` DOUBLE NULL,
    `value_9_min` DOUBLE NULL,
    `value_9_max` DOUBLE NULL,
    `value_10_min` DOUBLE NULL,
    `value_10_max` DOUBLE NULL,
    `value_11_min` DOUBLE NULL,
    `value_11_max` DOUBLE NULL,
    `value_13_min` DOUBLE NULL,
    `value_13_max` DOUBLE NULL,
    `value_15_min` DOUBLE NULL,
    `value_15_max` DOUBLE NULL,
    `value_20_min` DOUBLE NULL,
    `value_20_max` DOUBLE NULL,
    `value_25_min` DOUBLE NULL,
    `value_25_max` DOUBLE NULL,
    `value_30_min` DOUBLE NULL,
    `value_30_max` DOUBLE NULL,
    `value_35_min` DOUBLE NULL,
    `value_35_max` DOUBLE NULL,
    `value_40_min` DOUBLE NULL,
    `value_40_max` DOUBLE NULL,
    `value_45_min` DOUBLE NULL,
    `value_45_max` DOUBLE NULL,
    `value_50_min` DOUBLE NULL,
    `value_50_max` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `hardenability_range_additional_id` VARCHAR(255) NULL,

    UNIQUE INDEX `hardenability_ranges_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_additional_cost_triggers` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_additional_cost_id` BIGINT UNSIGNED NOT NULL,
    `trigger` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `index_hwe_additional_cost_triggers`(`hwe_additional_cost_id`, `trigger`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_additional_costs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_cost_type` VARCHAR(255) NOT NULL,
    `price` DOUBLE NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `valid_from` DATETIME(0) NULL,
    `valid_to` DATETIME(0) NULL,
    `cost_calc_type` VARCHAR(255) NULL,
    `lead_time_days` INTEGER NOT NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_certificate_hwe_qs_samples` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_certificate_id` BIGINT UNSIGNED NOT NULL,
    `hwe_qs_sample_id` BIGINT UNSIGNED NOT NULL,
    `note_qs_sample` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `hwe_certificate_hwe_qs_samples_hwe_certificate_id_foreign`(`hwe_certificate_id`),
    INDEX `hwe_certificate_hwe_qs_samples_hwe_qs_sample_id_foreign`(`hwe_qs_sample_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_certificates` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_id_qs_samples` BIGINT UNSIGNED NOT NULL,
    `prod_order_pos_id_ultrasonic` BIGINT UNSIGNED NULL,
    `note_ultrasonic` VARCHAR(255) NULL,
    `prod_order_pos_id_surface` BIGINT UNSIGNED NULL,
    `note_surface` VARCHAR(255) NULL,
    `prod_order_pos_id_heat_treatment` BIGINT UNSIGNED NULL,
    `note_heat_treatment` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `test_no` VARCHAR(255) NULL,
    `is_show_chemical_analysis` BOOLEAN NOT NULL DEFAULT true,
    `is_show_grain_size_determination` BOOLEAN NOT NULL DEFAULT true,
    `is_show_purity_determination` BOOLEAN NOT NULL DEFAULT true,
    `is_show_jominy_test` BOOLEAN NOT NULL DEFAULT true,
    `test_result_note` VARCHAR(255) NULL,
    `hardness_note` VARCHAR(255) NULL,
    `note_attachment` VARCHAR(255) NULL,
    `rev` INTEGER NOT NULL DEFAULT 0,
    `inspection_no` VARCHAR(255) NULL,
    `is_english` BOOLEAN NOT NULL DEFAULT false,
    `is_active` BOOLEAN NOT NULL DEFAULT true,

    INDEX `hwe_certificates_prod_order_pos_id_heat_treatment_foreign`(`prod_order_pos_id_heat_treatment`),
    INDEX `hwe_certificates_prod_order_pos_id_surface_foreign`(`prod_order_pos_id_surface`),
    INDEX `hwe_certificates_prod_order_pos_id_ultrasonic_foreign`(`prod_order_pos_id_ultrasonic`),
    UNIQUE INDEX `prod_order_pos_id_qs_samples_rev_unique`(`prod_order_pos_id_qs_samples`, `rev`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_freight_costs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `country_id` BIGINT UNSIGNED NOT NULL,
    `postal_code_from` VARCHAR(255) NOT NULL,
    `postal_code_to` VARCHAR(255) NOT NULL,
    `delivery_weight_from` DOUBLE NOT NULL DEFAULT 0,
    `delivery_weight_to` DOUBLE NOT NULL DEFAULT 0,
    `price` DOUBLE NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `hwe_freight_costs_unique`(`country_id`, `postal_code_from`, `postal_code_to`, `delivery_weight_from`, `delivery_weight_to`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_heat_treatment_costs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(255) NOT NULL,
    `cost` DOUBLE NOT NULL DEFAULT 0,
    `min_cost` DOUBLE NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_heat_treatment_factors` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `weight_from` DOUBLE NULL,
    `weight_to` DOUBLE NULL,
    `factor` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `material_group_type` VARCHAR(255) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_kalk_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `loggable_id` BIGINT UNSIGNED NOT NULL,
    `entity` VARCHAR(255) NOT NULL,
    `event` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `changing_remark` TEXT NULL,

    INDEX `hwe_kalk_logs_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_melt_analyses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `item_id` BIGINT UNSIGNED NULL,
    `delivery_specification` VARCHAR(255) NULL,
    `year` INTEGER NULL,
    `radioactivity` VARCHAR(255) NULL,
    `grain_size_testing_operator` VARCHAR(255) NULL,
    `grain_size_value` VARCHAR(255) NULL,
    `grain_size_testing_operator_hwe` VARCHAR(255) NULL,
    `grain_size_value_hwe` VARCHAR(255) NULL,
    `k3` DOUBLE NULL,
    `k4` DOUBLE NULL,
    `k3_hwe` DOUBLE NULL,
    `k4_hwe` DOUBLE NULL,
    `fine_a` DOUBLE NULL,
    `fine_b` DOUBLE NULL,
    `fine_c` DOUBLE NULL,
    `fine_d` DOUBLE NULL,
    `ds` DOUBLE NULL,
    `thick_a` DOUBLE NULL,
    `thick_b` DOUBLE NULL,
    `thick_c` DOUBLE NULL,
    `thick_d` DOUBLE NULL,
    `thick_ds` DOUBLE NULL,
    `fine_a_hwe` DOUBLE NULL,
    `fine_b_hwe` DOUBLE NULL,
    `fine_c_hwe` DOUBLE NULL,
    `fine_d_hwe` DOUBLE NULL,
    `ds_hwe` DOUBLE NULL,
    `thick_a_hwe` DOUBLE NULL,
    `thick_b_hwe` DOUBLE NULL,
    `thick_c_hwe` DOUBLE NULL,
    `thick_d_hwe` DOUBLE NULL,
    `thick_ds_hwe` DOUBLE NULL,
    `variant` VARCHAR(255) NULL,
    `j_1_sw` DOUBLE NULL,
    `j_1_5_sw` DOUBLE NULL,
    `j_2_sw` DOUBLE NULL,
    `j_3_sw` DOUBLE NULL,
    `j_4_sw` DOUBLE NULL,
    `j_5_sw` DOUBLE NULL,
    `j_6_sw` DOUBLE NULL,
    `j_7_sw` DOUBLE NULL,
    `j_8_sw` DOUBLE NULL,
    `j_9_sw` DOUBLE NULL,
    `j_10_sw` DOUBLE NULL,
    `j_11_sw` DOUBLE NULL,
    `j_13_sw` DOUBLE NULL,
    `j_15_sw` DOUBLE NULL,
    `j_20_sw` DOUBLE NULL,
    `j_25_sw` DOUBLE NULL,
    `j_30_sw` DOUBLE NULL,
    `j_35_sw` DOUBLE NULL,
    `j_40_sw` DOUBLE NULL,
    `j_45_sw` DOUBLE NULL,
    `j_50_sw` DOUBLE NULL,
    `j_1_hwe` DOUBLE NULL,
    `j_1_5_hwe` DOUBLE NULL,
    `j_2_hwe` DOUBLE NULL,
    `j_3_hwe` DOUBLE NULL,
    `j_4_hwe` DOUBLE NULL,
    `j_5_hwe` DOUBLE NULL,
    `j_6_hwe` DOUBLE NULL,
    `j_7_hwe` DOUBLE NULL,
    `j_8_hwe` DOUBLE NULL,
    `j_9_hwe` DOUBLE NULL,
    `j_10_hwe` DOUBLE NULL,
    `j_11_hwe` DOUBLE NULL,
    `j_13_hwe` DOUBLE NULL,
    `j_15_hwe` DOUBLE NULL,
    `j_20_hwe` DOUBLE NULL,
    `j_25_hwe` DOUBLE NULL,
    `j_30_hwe` DOUBLE NULL,
    `j_35_hwe` DOUBLE NULL,
    `j_40_hwe` DOUBLE NULL,
    `j_45_hwe` DOUBLE NULL,
    `j_50_hwe` DOUBLE NULL,
    `note` VARCHAR(255) NULL,
    `note_2` VARCHAR(255) NULL,
    `note_3` VARCHAR(255) NULL,
    `note_4` VARCHAR(255) NULL,
    `note_5` VARCHAR(255) NULL,
    `note_6` VARCHAR(255) NULL,
    `element_c` DOUBLE NULL,
    `element_si` DOUBLE NULL,
    `element_mn` DOUBLE NULL,
    `element_p` DOUBLE NULL,
    `element_s` DOUBLE NULL,
    `element_cr` DOUBLE NULL,
    `element_mo` DOUBLE NULL,
    `element_ni` DOUBLE NULL,
    `element_v` DOUBLE NULL,
    `element_ai` DOUBLE NULL,
    `element_h2` DOUBLE NULL,
    `element_cu` DOUBLE NULL,
    `element_w` DOUBLE NULL,
    `element_ti` DOUBLE NULL,
    `element_co` DOUBLE NULL,
    `element_b` DOUBLE NULL,
    `element_o2` DOUBLE NULL,
    `element_sn` DOUBLE NULL,
    `element_n` DOUBLE NULL,
    `element_nb` DOUBLE NULL,
    `element_ca` DOUBLE NULL,
    `element_c_hwe` DOUBLE NULL,
    `element_si_hwe` DOUBLE NULL,
    `element_mn_hwe` DOUBLE NULL,
    `element_p_hwe` DOUBLE NULL,
    `element_s_hwe` DOUBLE NULL,
    `element_cr_hwe` DOUBLE NULL,
    `element_mo_hwe` DOUBLE NULL,
    `element_ni_hwe` DOUBLE NULL,
    `element_v_hwe` DOUBLE NULL,
    `element_ai_hwe` DOUBLE NULL,
    `element_h2_hwe` DOUBLE NULL,
    `element_cu_hwe` DOUBLE NULL,
    `element_w_hwe` DOUBLE NULL,
    `element_ti_hwe` DOUBLE NULL,
    `element_co_hwe` DOUBLE NULL,
    `element_b_hwe` DOUBLE NULL,
    `element_o2_hwe` DOUBLE NULL,
    `element_sn_hwe` DOUBLE NULL,
    `element_n_hwe` DOUBLE NULL,
    `element_nb_hwe` DOUBLE NULL,
    `element_ca_hwe` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `material_analysis_id` BIGINT UNSIGNED NULL,
    `melting_type` VARCHAR(255) NULL,
    `quality_6336_5` VARCHAR(255) NULL,
    `purchase_order` VARCHAR(255) NULL,
    `purchase_order_pos` VARCHAR(255) NULL,
    `element_as` DOUBLE NULL,
    `element_as_hwe` DOUBLE NULL,
    `element_ta` DOUBLE NULL,
    `element_ta_hwe` DOUBLE NULL,
    `element_sb` DOUBLE NULL,
    `element_sb_hwe` DOUBLE NULL,
    `element_zr` DOUBLE NULL,
    `element_zr_hwe` DOUBLE NULL,
    `grain_size_specification` VARCHAR(255) NULL,
    `grain_size_procedure` VARCHAR(255) NULL,
    `grain_size_testing_scope` VARCHAR(255) NULL,
    `class_1` DOUBLE NULL,
    `class_2` DOUBLE NULL,
    `class_3` DOUBLE NULL,
    `class_4` DOUBLE NULL,
    `class_5` DOUBLE NULL,
    `class_6` DOUBLE NULL,
    `class_7` DOUBLE NULL,
    `class_8` DOUBLE NULL,
    `class_9` DOUBLE NULL,
    `class_10` DOUBLE NULL,
    `class_11` DOUBLE NULL,
    `class_12` DOUBLE NULL,
    `class_13` DOUBLE NULL,
    `class_14` DOUBLE NULL,
    `class_15` DOUBLE NULL,
    `class_16` DOUBLE NULL,
    `class_17` DOUBLE NULL,
    `class_18` DOUBLE NULL,

    INDEX `hwe_melt_analyses_item_id_foreign`(`item_id`),
    INDEX `hwe_melt_analyses_material_analysis_id_foreign`(`material_analysis_id`),
    UNIQUE INDEX `hwe_melt_analyses_custom_id_item_id_unique`(`custom_id`, `item_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_offer_pos_equipment` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `offer_pos_id` BIGINT UNSIGNED NOT NULL,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `hwe_offer_pos_equipment_offer_pos_id_item_id_unique`(`offer_pos_id`, `item_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_offer_pos_work_plan_lead_times` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `lead_time_days` INTEGER NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `min_lead_time_days` INTEGER NOT NULL DEFAULT 0,

    INDEX `hwe_offer_pos_work_plan_lead_times_machine_id_foreign`(`machine_id`),
    UNIQUE INDEX `hwe_offer_pos_work_plan_lead_times_name_machine_id_unique`(`name`, `machine_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_packaging_cost_product_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_packaging_cost_id` BIGINT UNSIGNED NOT NULL,
    `product_type` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `hwe_packaging_cost_product_types_hwe_packaging_cost_id_foreign`(`hwe_packaging_cost_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_packaging_costs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `outer_diameter_min` DOUBLE NULL,
    `outer_diameter_max` DOUBLE NULL,
    `height_min` DOUBLE NULL,
    `height_max` DOUBLE NULL,
    `weight_min` DOUBLE NULL,
    `weight_max` DOUBLE NULL,
    `quantity_min` DOUBLE NULL,
    `quantity_max` DOUBLE NULL,
    `cost` DOUBLE NULL,
    `packaging_cost_unit` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_prod_order_pos_operation_oven_protocols` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NOT NULL,
    `date` DATETIME(0) NOT NULL,
    `occupancy_type` VARCHAR(255) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `position` VARCHAR(255) NOT NULL,
    `occupancy` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `production_date` DATE NULL,
    `oven_row` VARCHAR(255) NULL,
    `oven_level` VARCHAR(255) NULL,
    `pre_heating` VARCHAR(255) NULL,
    `oven_loader` VARCHAR(255) NULL,
    `checked_by` VARCHAR(255) NULL,
    `oven_position_number` INTEGER NULL,
    `machine_id_source` BIGINT UNSIGNED NULL,
    `machine_id_position` BIGINT UNSIGNED NULL,
    `is_sample_piece` BOOLEAN NOT NULL DEFAULT false,
    `order_number_v10` VARCHAR(255) NULL,

    INDEX `hwe_prod_order_pos_operation_oven_protocols_machine_id_foreign`(`machine_id`),
    INDEX `oven_protocols_position_machine_id_foreign`(`machine_id_position`),
    INDEX `oven_protocols_source_machine_id_foreign`(`machine_id_source`),
    INDEX `prod_order_pos_operation_id_foreign_for_oven_protocols`(`prod_order_pos_operation_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_cleanliness_tests` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_id` BIGINT UNSIGNED NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `is_ok` BOOLEAN NOT NULL DEFAULT false,
    `cleanliness_specification` VARCHAR(255) NULL,
    `cleanliness_procedure` VARCHAR(255) NULL,
    `k1` DOUBLE NULL,
    `k3` DOUBLE NULL,
    `k4` DOUBLE NULL,
    `ss` DOUBLE NULL,
    `oa` DOUBLE NULL,
    `os` DOUBLE NULL,
    `og` DOUBLE NULL,
    `fine_a` DOUBLE NULL,
    `fine_b` DOUBLE NULL,
    `fine_c` DOUBLE NULL,
    `fine_d` DOUBLE NULL,
    `ds` DOUBLE NULL,
    `thick_a` DOUBLE NULL,
    `thick_b` DOUBLE NULL,
    `thick_c` DOUBLE NULL,
    `thick_d` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `user_id` BIGINT UNSIGNED NULL,

    INDEX `hwe_qs_cleanliness_tests_prod_order_pos_id_foreign`(`prod_order_pos_id`),
    INDEX `hwe_qs_cleanliness_tests_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `hwe_qs_cleanliness_tests_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_grain_size_tests` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_id` BIGINT UNSIGNED NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `is_ok` BOOLEAN NOT NULL DEFAULT false,
    `grain_size_specification` VARCHAR(255) NULL,
    `grain_size_procedure` VARCHAR(255) NULL,
    `grain_size_testing_scope` VARCHAR(255) NULL,
    `grain_size_testing_operator` VARCHAR(255) NULL,
    `value` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `user_id` BIGINT UNSIGNED NULL,

    INDEX `hwe_qs_grain_size_tests_prod_order_pos_id_foreign`(`prod_order_pos_id`),
    INDEX `hwe_qs_grain_size_tests_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `hwe_qs_grain_size_tests_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_hb_pos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_qs_hb_id` BIGINT UNSIGNED NULL,
    `serial` VARCHAR(255) NULL,
    `position` VARCHAR(255) NULL,
    `measurement` DOUBLE NULL,
    `checkpoint` VARCHAR(255) NULL,
    `value` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `hwe_qs_hb_pos_hwe_qs_hb_id_foreign`(`hwe_qs_hb_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_hbs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_id` BIGINT UNSIGNED NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_ok` BOOLEAN NOT NULL DEFAULT false,
    `user_id` BIGINT UNSIGNED NULL,

    INDEX `hwe_qs_hbs_prod_order_pos_id_foreign`(`prod_order_pos_id`),
    INDEX `hwe_qs_hbs_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `hwe_qs_hbs_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_impact_test_pos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_qs_impact_test_id` BIGINT UNSIGNED NULL,
    `temperature` DOUBLE NULL,
    `value_1` DOUBLE NULL,
    `value_2` DOUBLE NULL,
    `value_3` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `hwe_qs_impact_test_pos_hwe_qs_impact_test_id_foreign`(`hwe_qs_impact_test_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_impact_tests` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_id` BIGINT UNSIGNED NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `is_ok` BOOLEAN NOT NULL DEFAULT false,
    `hwe_qs_sample_id` BIGINT UNSIGNED NULL,
    `lateral_expansion_1` DOUBLE NULL,
    `lateral_expansion_2` DOUBLE NULL,
    `lateral_expansion_3` DOUBLE NULL,
    `fracture_surface_area_1` DOUBLE NULL,
    `fracture_surface_area_2` DOUBLE NULL,
    `fracture_surface_area_3` DOUBLE NULL,
    `fracture_type` VARCHAR(255) NULL,
    `toughness_1` DOUBLE NULL,
    `toughness_2` DOUBLE NULL,
    `toughness_3` DOUBLE NULL,
    `hardness` DOUBLE NULL,
    `hardness_uom` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `user_id` BIGINT UNSIGNED NULL,

    INDEX `hwe_qs_impact_tests_hwe_qs_sample_id_foreign`(`hwe_qs_sample_id`),
    INDEX `hwe_qs_impact_tests_prod_order_pos_id_foreign`(`prod_order_pos_id`),
    INDEX `hwe_qs_impact_tests_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `hwe_qs_impact_tests_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_jominy_tests` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_id` BIGINT UNSIGNED NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `is_ok` BOOLEAN NOT NULL DEFAULT false,
    `variant` VARCHAR(255) NULL,
    `value_1` DOUBLE NULL,
    `value_1_5` DOUBLE NULL,
    `value_2` DOUBLE NULL,
    `value_3` DOUBLE NULL,
    `value_4` DOUBLE NULL,
    `value_5` DOUBLE NULL,
    `value_6` DOUBLE NULL,
    `value_7` DOUBLE NULL,
    `value_8` DOUBLE NULL,
    `value_9` DOUBLE NULL,
    `value_10` DOUBLE NULL,
    `value_11` DOUBLE NULL,
    `value_13` DOUBLE NULL,
    `value_15` DOUBLE NULL,
    `value_20` DOUBLE NULL,
    `value_25` DOUBLE NULL,
    `value_30` DOUBLE NULL,
    `value_35` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `value_40` DOUBLE NULL,
    `value_45` DOUBLE NULL,
    `value_50` DOUBLE NULL,
    `user_id` BIGINT UNSIGNED NULL,

    INDEX `hwe_qs_jominy_tests_prod_order_pos_id_foreign`(`prod_order_pos_id`),
    INDEX `hwe_qs_jominy_tests_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `hwe_qs_jominy_tests_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_mt_norms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_id` BIGINT UNSIGNED NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `is_ok` BOOLEAN NOT NULL DEFAULT false,
    `specification` VARCHAR(255) NULL,
    `revision` VARCHAR(255) NULL,
    `test_class` VARCHAR(255) NULL,
    `testing_facility` VARCHAR(255) NULL,
    `test_equipment` VARCHAR(255) NULL,
    `uv_lamp` VARCHAR(255) NULL,
    `test_range` VARCHAR(255) NULL,
    `magnetization` VARCHAR(255) NULL,
    `current_type` VARCHAR(255) NULL,
    `illuminance` VARCHAR(255) NULL,
    `irradiance` VARCHAR(255) NULL,
    `registration_limit` VARCHAR(255) NULL,
    `lux_meter` VARCHAR(255) NULL,
    `field_strength_meter` VARCHAR(255) NULL,
    `uv_meter` VARCHAR(255) NULL,
    `comments` VARCHAR(255) NULL,
    `residual_magnetism` VARCHAR(255) NULL,
    `control_unit` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `user_id` BIGINT UNSIGNED NULL,

    INDEX `hwe_qs_mt_norms_prod_order_pos_id_foreign`(`prod_order_pos_id`),
    INDEX `hwe_qs_mt_norms_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `hwe_qs_mt_norms_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_pt_norms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_id` BIGINT UNSIGNED NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `is_ok` BOOLEAN NOT NULL DEFAULT false,
    `name` VARCHAR(255) NULL,
    `specification` VARCHAR(255) NULL,
    `issue_revision_status` VARCHAR(255) NULL,
    `quality_class` VARCHAR(255) NULL,
    `test_scope` VARCHAR(255) NULL,
    `test_equipment` VARCHAR(255) NULL,
    `test_temperature` VARCHAR(255) NULL,
    `developer` VARCHAR(255) NULL,
    `penetrant` VARCHAR(255) NULL,
    `intermediate_cleaner` VARCHAR(255) NULL,
    `illuminance_lux` VARCHAR(255) NULL,
    `cleaner` VARCHAR(255) NULL,
    `registration_limit` VARCHAR(255) NULL,
    `control_unit` VARCHAR(255) NULL,
    `comments` VARCHAR(255) NULL,
    `lux_meter` VARCHAR(255) NULL,
    `batch_developer` VARCHAR(255) NULL,
    `batch_penetrant` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `user_id` BIGINT UNSIGNED NULL,

    INDEX `hwe_qs_pt_norms_prod_order_pos_id_foreign`(`prod_order_pos_id`),
    INDEX `hwe_qs_pt_norms_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `hwe_qs_pt_norms_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_samples` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `date` DATE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `orientation` VARCHAR(255) NULL,
    `customer_number` VARCHAR(255) NULL,

    UNIQUE INDEX `hwe_qs_samples_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_samples_prod_order_pos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_qs_sample_id` BIGINT UNSIGNED NOT NULL,
    `prod_order_pos_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `hwe_qs_samples_prod_order_pos_prod_order_pos_id_foreign`(`prod_order_pos_id`),
    UNIQUE INDEX `unique_hwe_qs_prod_order`(`hwe_qs_sample_id`, `prod_order_pos_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_tensile_tests` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_id` BIGINT UNSIGNED NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `is_ok` BOOLEAN NOT NULL DEFAULT false,
    `hwe_qs_sample_id` BIGINT UNSIGNED NULL,
    `reh` DOUBLE NULL,
    `rp_0_2` DOUBLE NULL,
    `rm` DOUBLE NULL,
    `a5` DOUBLE NULL,
    `z` DOUBLE NULL,
    `rp_1_0` DOUBLE NULL,
    `rt_0_5` DOUBLE NULL,
    `e_module` DOUBLE NULL,
    `rp_rm_ratio` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `user_id` BIGINT UNSIGNED NULL,

    INDEX `hwe_qs_tensile_tests_hwe_qs_sample_id_foreign`(`hwe_qs_sample_id`),
    INDEX `hwe_qs_tensile_tests_prod_order_pos_id_foreign`(`prod_order_pos_id`),
    INDEX `hwe_qs_tensile_tests_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `hwe_qs_tensile_tests_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_us_norm_adjustments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_qs_us_norm_id` BIGINT UNSIGNED NOT NULL,
    `adjustment` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `hwe_qs_us_norm_adjustments_hwe_qs_us_norm_id_adjustment_index`(`hwe_qs_us_norm_id`, `adjustment`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_us_norm_rating_justifications` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_qs_us_norm_rating_id` BIGINT UNSIGNED NOT NULL,
    `justification` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `hw_qs_us_norm_rating_justifications_idx`(`hwe_qs_us_norm_rating_id`, `justification`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_us_norm_ratings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_qs_us_norm_id` BIGINT UNSIGNED NOT NULL,
    `rating` VARCHAR(255) NULL,
    `probe` VARCHAR(255) NULL,
    `test_direction` VARCHAR(255) NULL,
    `sender_section` DOUBLE NULL,
    `amplification` DOUBLE NULL,
    `ksr` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `hwe_qs_us_norm_ratings_hwe_qs_us_norm_id_foreign`(`hwe_qs_us_norm_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_us_norm_test_scopes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_qs_us_norm_id` BIGINT UNSIGNED NOT NULL,
    `test_scope` VARCHAR(255) NULL,
    `probe` VARCHAR(255) NULL,
    `test_direction` VARCHAR(255) NULL,
    `sound_attenuation` DOUBLE NULL,
    `sound_attenuation_operator` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `hwe_qs_us_norm_test_scopes_hwe_qs_us_norm_id_foreign`(`hwe_qs_us_norm_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_us_norm_test_sections` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_qs_us_norm_id` BIGINT UNSIGNED NOT NULL,
    `test_section` VARCHAR(255) NULL,
    `registration_threshold` DOUBLE NULL,
    `reporting_threshold` DOUBLE NULL,
    `decision_threshold` DOUBLE NULL,
    `allowed_threshold` DOUBLE NULL,
    `expansion_with` DOUBLE NULL,
    `expansion_without` DOUBLE NULL,
    `registration_threshold_operator` VARCHAR(255) NULL,
    `reporting_threshold_operator` VARCHAR(255) NULL,
    `decision_threshold_operator` VARCHAR(255) NULL,
    `allowed_threshold_operator` VARCHAR(255) NULL,
    `expansion_with_operator` VARCHAR(255) NULL,
    `expansion_without_operator` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `scrap_limit` DOUBLE NULL,
    `scrap_limit_operator` VARCHAR(255) NULL,

    INDEX `hwe_qs_us_norm_test_sections_hwe_qs_us_norm_id_foreign`(`hwe_qs_us_norm_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_us_norms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_id` BIGINT UNSIGNED NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `is_ok` BOOLEAN NOT NULL DEFAULT false,
    `issue` VARCHAR(255) NULL,
    `quality_class` VARCHAR(255) NULL,
    `surface_finish` VARCHAR(255) NULL,
    `coupling` VARCHAR(255) NOT NULL DEFAULT 'PASTE',
    `amplification` VARCHAR(255) NOT NULL DEFAULT 'AVG',
    `detection_threshold` DOUBLE NULL,
    `residual_magnetism` DOUBLE NULL,
    `detection_threshold_operator` VARCHAR(255) NULL,
    `note` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `testing_device` VARCHAR(255) NULL,
    `specification` VARCHAR(255) NULL,
    `user_id` BIGINT UNSIGNED NULL,

    INDEX `hwe_qs_us_norms_prod_order_pos_id_foreign`(`prod_order_pos_id`),
    INDEX `hwe_qs_us_norms_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `hwe_qs_us_norms_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_vt_norm_auxiliary_means` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_qs_vt_norm_id` BIGINT UNSIGNED NOT NULL,
    `auxiliary_mean` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `qs_vt_norm_aux_mean_idx`(`hwe_qs_vt_norm_id`, `auxiliary_mean`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_vt_norm_test_techniques` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_qs_vt_norm_id` BIGINT UNSIGNED NOT NULL,
    `test_technique` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `qs_vt_norm_test_techniques_idx`(`hwe_qs_vt_norm_id`, `test_technique`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_qs_vt_norms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_id` BIGINT UNSIGNED NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `is_ok` BOOLEAN NOT NULL DEFAULT false,
    `name` VARCHAR(255) NULL,
    `specification` VARCHAR(255) NULL,
    `revision` VARCHAR(255) NULL,
    `quality_class` VARCHAR(255) NULL,
    `test_scope` VARCHAR(255) NULL,
    `illuminance` VARCHAR(255) NULL,
    `registration_limit` VARCHAR(255) NULL,
    `surface_quality` VARCHAR(255) NULL,
    `lux_meter` VARCHAR(255) NULL,
    `comments` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `user_id` BIGINT UNSIGNED NULL,

    INDEX `hwe_qs_vt_norms_prod_order_pos_id_foreign`(`prod_order_pos_id`),
    INDEX `hwe_qs_vt_norms_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `hwe_qs_vt_norms_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_ring_rolling_factors` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `weight_from` DOUBLE NULL,
    `weight_to` DOUBLE NULL,
    `factor` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_work_plan_additional_heat_treatments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_work_plan_id` BIGINT UNSIGNED NOT NULL,
    `pos` INTEGER NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `hwe_work_plan_id_pos_type_unique`(`hwe_work_plan_id`, `pos`, `type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_work_plan_heat_treatments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hwe_work_plan_id` BIGINT UNSIGNED NOT NULL,
    `pos` INTEGER NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    `internal_note` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `hwe_work_plan_heat_treatments_hwe_work_plan_id_pos_type_unique`(`hwe_work_plan_id`, `pos`, `type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hwe_work_plans` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `hwe_work_plans_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `id_generator_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `entity` VARCHAR(255) NOT NULL,
    `table` VARCHAR(255) NOT NULL,
    `prefix` VARCHAR(255) NOT NULL,
    `field` VARCHAR(255) NOT NULL,
    `length` INTEGER NOT NULL DEFAULT 8,
    `reset_on_prefix_change` BOOLEAN NOT NULL DEFAULT true,
    `is_date_prefix` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `id_generator_settings_entity_unique`(`entity`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inspection_lots` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `item_plant_id` BIGINT UNSIGNED NULL,
    `inspectable_type` VARCHAR(255) NOT NULL,
    `inspectable_id` BIGINT UNSIGNED NOT NULL,

    UNIQUE INDEX `inspection_lots_custom_id_unique`(`custom_id`),
    INDEX `inspection_lots_inspectable_type_inspectable_id_index`(`inspectable_type`, `inspectable_id`),
    INDEX `inspection_lots_item_plant_id_foreign`(`item_plant_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inspection_operation_characteristic_options` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `inspection_operation_characteristic_id` BIGINT UNSIGNED NOT NULL,
    `attribute_set_option_id` BIGINT UNSIGNED NULL,
    `custom_id` VARCHAR(255) NOT NULL,
    `valuation` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `option_attribute_set_foreign`(`attribute_set_option_id`),
    UNIQUE INDEX `operation_characteristic_custom_id_unique`(`inspection_operation_characteristic_id`, `custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inspection_operation_characteristics` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `characteristicable_type` VARCHAR(255) NOT NULL,
    `characteristicable_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `is_quantitative` BOOLEAN NOT NULL DEFAULT true,
    `value_target` DOUBLE NULL,
    `value_lower_limit` DOUBLE NULL,
    `value_upper_limit` DOUBLE NULL,
    `decimals` INTEGER NOT NULL DEFAULT 0,
    `unit_of_measure_id_value` BIGINT UNSIGNED NULL,
    `sample_size` INTEGER NOT NULL DEFAULT 1,
    `unit_of_measure_id_sample` BIGINT UNSIGNED NULL,
    `attribute_set_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `user_group_id` BIGINT UNSIGNED NULL,
    `is_required` BOOLEAN NOT NULL DEFAULT true,
    `inspection_specification_importance_code_id` BIGINT UNSIGNED NULL,
    `value_lower_limit_plausible` DOUBLE NULL,
    `value_upper_limit_plausible` DOUBLE NULL,
    `is_note_required` BOOLEAN NOT NULL DEFAULT false,

    INDEX `characteristicable_index`(`characteristicable_type`, `characteristicable_id`),
    INDEX `fk_char_unit_of_measure_id_sample`(`unit_of_measure_id_sample`),
    INDEX `fk_char_unit_of_measure_id_value`(`unit_of_measure_id_value`),
    INDEX `inspection_operation_characteristics_attribute_set_id_foreign`(`attribute_set_id`),
    INDEX `inspection_operation_characteristics_user_group_index`(`user_group_id`),
    INDEX `ioc_isimportancecode_fk`(`inspection_specification_importance_code_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inspection_plans` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `frequency` VARCHAR(255) NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    `item_id` BIGINT UNSIGNED NULL,
    `operation_plan_pos_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `inspection_plans_custom_id_unique`(`custom_id`),
    INDEX `inspection_plans_item_id_foreign`(`item_id`),
    INDEX `inspection_plans_operation_plan_pos_id_foreign`(`operation_plan_pos_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inspection_point_characteristic_options` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `inspection_point_characteristic_id` BIGINT UNSIGNED NOT NULL,
    `inspection_operation_characteristic_option_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `point_char_opt_ope_char_opt_foreign`(`inspection_operation_characteristic_option_id`),
    INDEX `point_char_opt_point_char_foreign`(`inspection_point_characteristic_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inspection_point_characteristics` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `inspection_point_id` BIGINT UNSIGNED NOT NULL,
    `inspection_operation_characteristic_id` BIGINT UNSIGNED NOT NULL,
    `value` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_exported` BOOLEAN NOT NULL DEFAULT false,
    `confirmation_number` INTEGER NULL,
    `field_note` TEXT NULL,
    `user_id` BIGINT UNSIGNED NULL,

    INDEX `inspection_point_characteristics_user_id_foreign`(`user_id`),
    INDEX `inspection_point_index`(`inspection_point_id`, `inspection_operation_characteristic_id`),
    INDEX `point_char_operation_char_foreign`(`inspection_operation_characteristic_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inspection_points` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `inspectable_type` VARCHAR(255) NOT NULL,
    `inspectable_id` BIGINT UNSIGNED NOT NULL,
    `is_automatically_triggered` BOOLEAN NOT NULL,
    `user_id_creator` BIGINT UNSIGNED NULL,
    `registered_datetime` DATETIME(0) NOT NULL,
    `custom_id` VARCHAR(255) NULL,
    `inspection_lot_id` BIGINT UNSIGNED NULL,
    `machine_cycle_id_trigger` BIGINT UNSIGNED NULL,
    `capacity_id_trigger` BIGINT UNSIGNED NULL,

    INDEX `inspection_points_capacity_id_trigger_foreign`(`capacity_id_trigger`),
    INDEX `inspection_points_inspectable_type_inspectable_id_index`(`inspectable_type`, `inspectable_id`),
    INDEX `inspection_points_inspection_lot_id_foreign`(`inspection_lot_id`),
    INDEX `inspection_points_machine_cycle_id_trigger_foreign`(`machine_cycle_id_trigger`),
    INDEX `inspection_points_user_id_creator_foreign`(`user_id_creator`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inspection_specification_importance_codes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `icon_type` VARCHAR(255) NULL,

    UNIQUE INDEX `inspection_specification_importance_codes_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inspection_specifications` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `plant_id` BIGINT UNSIGNED NOT NULL,
    `inspection_specification_importance_code_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `inspection_specifications_plant_id_foreign`(`plant_id`),
    INDEX `is_isimportance_code_fk`(`inspection_specification_importance_code_id`),
    UNIQUE INDEX `inspection_specifications_custom_id_plant_id_unique`(`custom_id`, `plant_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `item_bom_children` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `child_item_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NOT NULL,
    `qty_child_for_one_parent` DOUBLE NOT NULL DEFAULT 1,
    `lead_time_days` INTEGER NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `item_bom_children_child_item_id_foreign`(`child_item_id`),
    UNIQUE INDEX `item_bom_children_item_id_child_item_id_pos_unique`(`item_id`, `child_item_id`, `pos`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `item_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `sort_order` INTEGER NULL,
    `scan_creates_inspection_point` BOOLEAN NULL DEFAULT false,

    UNIQUE INDEX `item_groups_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `item_packaging_items` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `packaging_item_id` BIGINT UNSIGNED NULL,
    `is_default` BOOLEAN NOT NULL DEFAULT false,
    `qty_in_packaging_item` INTEGER NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `item_packaging_items_item_id_foreign`(`item_id`),
    INDEX `item_packaging_items_packaging_item_id_foreign`(`packaging_item_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `item_plant_storage_locations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_plant_id` BIGINT UNSIGNED NOT NULL,
    `storage_location_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `item_plant_storage_locations_item_plant_id_foreign`(`item_plant_id`),
    INDEX `item_plant_storage_locations_storage_location_id_foreign`(`storage_location_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `item_plants` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `plant_id` BIGINT UNSIGNED NOT NULL,
    `is_batch_managed` BOOLEAN NOT NULL DEFAULT false,
    `storage_location_id` BIGINT UNSIGNED NULL,
    `storage_location_id_rework` BIGINT UNSIGNED NULL,
    `storage_location_id_scrap` BIGINT UNSIGNED NULL,
    `serial_number_profile_id` BIGINT UNSIGNED NULL,

    INDEX `item_plant_plant_id_foreign`(`plant_id`),
    INDEX `item_plants_serial_number_profile_id_foreign`(`serial_number_profile_id`),
    INDEX `item_plants_storage_location_id_foreign`(`storage_location_id`),
    INDEX `item_plants_storage_location_id_rework_foreign`(`storage_location_id_rework`),
    INDEX `item_plants_storage_location_id_scrap_foreign`(`storage_location_id_scrap`),
    UNIQUE INDEX `item_plant_item_id_plant_id_unique`(`item_id`, `plant_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `item_state_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `item_state_groups_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `item_state_halls` (
    `item_state_id` BIGINT UNSIGNED NOT NULL,
    `hall_id` BIGINT UNSIGNED NOT NULL,

    INDEX `bad_part_reasons_halls_hall_id_foreign`(`hall_id`),
    INDEX `item_state_halls_item_state_id_foreign`(`item_state_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `item_state_machines` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_state_id` BIGINT UNSIGNED NOT NULL,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `bad_part_reason_machines_machine_id_foreign`(`machine_id`),
    UNIQUE INDEX `bad_part_reason_machines_bad_part_reason_id_machine_id_unique`(`item_state_id`, `machine_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `item_states` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `item_state_type` VARCHAR(255) NOT NULL DEFAULT 'SCRAP',
    `item_state_group_id` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `item_states_custom_id_unique`(`custom_id`),
    INDEX `item_states_item_state_group_id_foreign`(`item_state_group_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `item_tasks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `task_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `item_tasks_item_id_foreign`(`item_id`),
    INDEX `item_tasks_task_id_foreign`(`task_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `item_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `is_stocked_in_hu` BOOLEAN NOT NULL DEFAULT false,
    `is_packaging` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `item_types_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `item_unit_of_measure_conversions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `unit_of_measure_id` BIGINT UNSIGNED NOT NULL,
    `quantity_denominator` INTEGER NOT NULL,
    `quantity_numerator` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `item_unit_of_measure_conversions_unit_of_measure_id_foreign`(`unit_of_measure_id`),
    UNIQUE INDEX `item_unit_of_measure_conversions_unique`(`item_id`, `unit_of_measure_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `items` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `operation_plan_id` BIGINT UNSIGNED NULL,
    `bom_id` BIGINT UNSIGNED NULL,
    `name3` VARCHAR(40) NULL,
    `name` VARCHAR(255) NOT NULL,
    `name2` VARCHAR(255) NULL,
    `is_sales_item` BOOLEAN NOT NULL DEFAULT false,
    `is_alloy` BOOLEAN NOT NULL DEFAULT false,
    `use_stock_for_backlog` BOOLEAN NOT NULL DEFAULT true,
    `use_for_capacity_planning` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `price` DOUBLE NULL DEFAULT 0,
    `stock` DOUBLE NULL DEFAULT 0,
    `hwe_period_month` INTEGER NULL DEFAULT 0,
    `hwe_period_year` INTEGER NULL DEFAULT 0,
    `hwe_norm_name` VARCHAR(255) NULL,
    `hwe_warehouse_material` VARCHAR(255) NULL,
    `is_packaging_item` BOOLEAN NOT NULL DEFAULT false,
    `item_group_id` BIGINT UNSIGNED NULL,
    `category` VARCHAR(255) NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `is_tool` BOOLEAN NULL,
    `plant_id` BIGINT UNSIGNED NULL,
    `unit_of_measure_id` BIGINT UNSIGNED NULL,
    `price_plan` DOUBLE NULL,
    `packaging_quantity` DOUBLE NULL,
    `packaging_instruction_id` BIGINT UNSIGNED NULL,
    `packaging_instruction_id_2` BIGINT UNSIGNED NULL,
    `packaging_instruction_id_3` BIGINT UNSIGNED NULL,
    `packaging_instruction_id_4` BIGINT UNSIGNED NULL,
    `note` VARCHAR(255) NULL,
    `height` VARCHAR(255) NULL,
    `width` VARCHAR(255) NULL,
    `length` VARCHAR(255) NULL,
    `total_weight` VARCHAR(255) NULL,
    `price_plan_date` DATE NULL,
    `packaging_instruction_id_1` BIGINT UNSIGNED NULL,
    `is_production_item` BOOLEAN NOT NULL DEFAULT false,
    `is_purchased_item` BOOLEAN NOT NULL DEFAULT false,
    `main_tool_id` VARCHAR(255) NULL,
    `item_type_id` BIGINT UNSIGNED NULL,
    `batch_quantity` DOUBLE NULL,
    `repair_req_percentage` VARCHAR(255) NULL,
    `hwe_tool_category` VARCHAR(255) NULL,

    INDEX `items_bom_id_foreign`(`bom_id`),
    INDEX `items_item_group_id_foreign`(`item_group_id`),
    INDEX `items_item_type_id_foreign`(`item_type_id`),
    INDEX `items_operation_plan_id_foreign`(`operation_plan_id`),
    INDEX `items_packaging_instruction_id_1_foreign`(`packaging_instruction_id_1`),
    INDEX `items_packaging_instruction_id_2_foreign`(`packaging_instruction_id_2`),
    INDEX `items_packaging_instruction_id_3_foreign`(`packaging_instruction_id_3`),
    INDEX `items_packaging_instruction_id_4_foreign`(`packaging_instruction_id_4`),
    INDEX `items_packaging_instruction_id_foreign`(`packaging_instruction_id`),
    INDEX `items_plant_id_foreign`(`plant_id`),
    INDEX `items_unit_of_measure_id_foreign`(`unit_of_measure_id`),
    UNIQUE INDEX `items_custom_id_plant_id_unique`(`custom_id`, `plant_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jobs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `queue` VARCHAR(255) NOT NULL,
    `payload` LONGTEXT NOT NULL,
    `attempts` TINYINT UNSIGNED NOT NULL,
    `reserved_at` INTEGER UNSIGNED NULL,
    `available_at` INTEGER UNSIGNED NOT NULL,
    `created_at` INTEGER UNSIGNED NOT NULL,

    INDEX `jobs_queue_index`(`queue`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_calendar_exceptions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `jpi_resource_id` BIGINT UNSIGNED NOT NULL,
    `date` DATE NOT NULL,
    `work_time` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `jpi_calendar_exceptions_jpi_resource_id_foreign`(`jpi_resource_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_job_predecessors` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `jpi_job_id` BIGINT UNSIGNED NOT NULL,
    `predecessor_jpi_job_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `jpi_job_predecessors_jpi_job_id_foreign`(`jpi_job_id`),
    INDEX `jpi_job_predecessors_predecessor_jpi_job_id_foreign`(`predecessor_jpi_job_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_job_tasks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `jpi_job_id` BIGINT UNSIGNED NULL,
    `jpi_task_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `jpi_job_tasks_jpi_job_id_foreign`(`jpi_job_id`),
    INDEX `jpi_job_tasks_jpi_task_id_foreign`(`jpi_task_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_job_template_tasks` (
    `jpi_job_template_id` BIGINT UNSIGNED NOT NULL,
    `jpi_task_id` BIGINT UNSIGNED NOT NULL,

    INDEX `jpi_job_template_tasks_jpi_job_template_id_foreign`(`jpi_job_template_id`),
    INDEX `jpi_job_template_tasks_jpi_task_id_foreign`(`jpi_task_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_job_templates` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `jpi_guid` VARCHAR(255) NULL,
    `model_type` VARCHAR(255) NOT NULL,
    `model_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `jpi_job_templates_model_type_model_id_index`(`model_type`, `model_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_jobs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `model_type` VARCHAR(255) NOT NULL,
    `model_id` BIGINT UNSIGNED NOT NULL,
    `jpi_guid` VARCHAR(255) NULL,
    `name` VARCHAR(255) NULL,
    `due_date` DATETIME(0) NULL,
    `release_date` DATETIME(0) NULL,
    `order_status` VARCHAR(255) NOT NULL DEFAULT 'QUOTED',
    `quantity` INTEGER NOT NULL DEFAULT 0,
    `custom_field_value_1` VARCHAR(255) NULL,
    `custom_field_value_2` VARCHAR(255) NULL,
    `custom_field_value_3` VARCHAR(255) NULL,
    `custom_field_value_4` VARCHAR(255) NULL,
    `custom_field_value_5` VARCHAR(255) NULL,
    `custom_field_value_6` VARCHAR(255) NULL,
    `custom_field_value_7` VARCHAR(255) NULL,
    `custom_field_value_8` VARCHAR(255) NULL,
    `custom_field_value_9` VARCHAR(255) NULL,
    `custom_field_value_10` VARCHAR(255) NULL,
    `automatic` BOOLEAN NOT NULL DEFAULT true,
    `job_note` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `planned_start` DATETIME(0) NULL,
    `planned_end` DATETIME(0) NULL,
    `is_deleted` BOOLEAN NOT NULL DEFAULT false,
    `is_exported` BOOLEAN NOT NULL DEFAULT true,
    `customer` VARCHAR(255) NULL,
    `strategy` ENUM('ASAP', 'JIT') NOT NULL DEFAULT 'ASAP',
    `is_exporting` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `jpi_jobs_name_unique`(`name`),
    INDEX `jpi_jobs_model_type_model_id_index`(`model_type`, `model_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_resource_categories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `jpi_guid` VARCHAR(255) NULL,
    `model_type` VARCHAR(255) NOT NULL,
    `model_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_deleted` BOOLEAN NOT NULL DEFAULT false,

    INDEX `jpi_resource_categories_model_type_model_id_index`(`model_type`, `model_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_resource_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `jpi_guid` VARCHAR(255) NULL,
    `model_type` VARCHAR(255) NOT NULL,
    `model_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `name` VARCHAR(255) NULL,
    `is_deleted` BOOLEAN NOT NULL DEFAULT false,
    `jpi_resource_category_id` BIGINT UNSIGNED NULL,

    INDEX `jpi_resource_groups_jpi_resource_category_id_foreign`(`jpi_resource_category_id`),
    INDEX `jpi_resource_groups_model_type_model_id_index`(`model_type`, `model_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_resource_resource_groups` (
    `jpi_resource_id` BIGINT UNSIGNED NOT NULL,
    `jpi_resource_group_id` BIGINT UNSIGNED NOT NULL,

    INDEX `jpi_resource_resource_groups_jpi_resource_group_id_foreign`(`jpi_resource_group_id`),
    INDEX `jpi_resource_resource_groups_jpi_resource_id_foreign`(`jpi_resource_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_resources` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `jpi_guid` VARCHAR(255) NULL,
    `model_type` VARCHAR(255) NOT NULL,
    `model_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `name` VARCHAR(255) NULL,
    `capacity` DOUBLE NOT NULL DEFAULT 1,
    `disabled` BOOLEAN NOT NULL DEFAULT false,
    `finite` BOOLEAN NULL DEFAULT true,
    `is_deleted` BOOLEAN NOT NULL DEFAULT false,

    INDEX `jpi_resources_model_type_model_id_index`(`model_type`, `model_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_task_assigned_resources` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `jpi_task_id` BIGINT UNSIGNED NOT NULL,
    `jpi_resource_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `jpi_task_assigned_resources_jpi_resource_id_foreign`(`jpi_resource_id`),
    INDEX `jpi_task_assigned_resources_jpi_task_id_foreign`(`jpi_task_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_task_predecessors` (
    `jpi_task_id` BIGINT UNSIGNED NOT NULL,
    `predecessor_jpi_task_id` BIGINT UNSIGNED NULL,
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,

    INDEX `jpi_task_predecessors_jpi_task_id_foreign`(`jpi_task_id`),
    INDEX `jpi_task_predecessors_predecessor_jpi_task_id_foreign`(`predecessor_jpi_task_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_task_resource_group_constraint_resource_constraints` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `jpi_task_resource_group_constraint_id` BIGINT UNSIGNED NOT NULL,
    `jpi_resource_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `resource_usage` DOUBLE NULL DEFAULT 1,

    INDEX `jpi_resource_id_foreign`(`jpi_resource_id`),
    INDEX `jpi_task_resource_group_constraint_id_foreign`(`jpi_task_resource_group_constraint_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_task_resource_group_constraints` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `jpi_task_id` BIGINT UNSIGNED NOT NULL,
    `jpi_resource_group_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `usage_factor` DOUBLE NOT NULL DEFAULT 1,

    INDEX `jpi_resource_group_id_foreign`(`jpi_resource_group_id`),
    INDEX `jpi_task_id_foreign`(`jpi_task_id`),
    UNIQUE INDEX `alt_unique`(`jpi_task_id`, `jpi_resource_group_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_tasks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `jpi_guid` VARCHAR(255) NULL,
    `task_no` VARCHAR(255) NULL,
    `name` VARCHAR(255) NULL,
    `production_time_per_unit` DOUBLE NOT NULL DEFAULT 0,
    `quantity` INTEGER NOT NULL DEFAULT 0,
    `total_done_quantity` INTEGER NOT NULL DEFAULT 0,
    `custom_field_value_1` VARCHAR(255) NULL,
    `custom_field_value_2` VARCHAR(255) NULL,
    `custom_field_value_3` VARCHAR(255) NULL,
    `custom_field_value_4` VARCHAR(255) NULL,
    `custom_field_value_5` VARCHAR(255) NULL,
    `custom_field_value_6` VARCHAR(255) NULL,
    `custom_field_value_7` VARCHAR(255) NULL,
    `custom_field_value_8` VARCHAR(255) NULL,
    `custom_field_value_9` VARCHAR(255) NULL,
    `custom_field_value_10` VARCHAR(255) NULL,
    `setup_time` DOUBLE NOT NULL DEFAULT 0,
    `teardown_time` INTEGER NOT NULL DEFAULT 0,
    `transfer_time` INTEGER NOT NULL DEFAULT 0,
    `start_not_earlier_than` DATETIME(0) NULL,
    `send_ahead_quantity` DOUBLE NULL DEFAULT 0,
    `shopfloor_total_done_quantity` INTEGER NOT NULL DEFAULT 0,
    `processing_end` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `model_type` VARCHAR(255) NOT NULL,
    `model_id` BIGINT UNSIGNED NOT NULL,
    `processing_start` DATETIME(0) NULL,
    `planned_start` DATETIME(0) NULL,
    `planned_end` DATETIME(0) NULL,
    `is_deleted` BOOLEAN NOT NULL DEFAULT false,
    `assigned_resource1` BIGINT UNSIGNED NULL,
    `assigned_resource2` BIGINT UNSIGNED NULL,
    `processing_resource1` BIGINT UNSIGNED NULL,
    `processing_resource2` BIGINT UNSIGNED NULL,
    `processing_resource_group1` BIGINT UNSIGNED NULL,
    `processing_resource_group2` BIGINT UNSIGNED NULL,
    `is_exported` BOOLEAN NOT NULL DEFAULT true,
    `assigned_resource_group1` BIGINT UNSIGNED NULL,
    `assigned_resource_group2` BIGINT UNSIGNED NULL,
    `is_exporting` BOOLEAN NOT NULL DEFAULT false,

    INDEX `jpi_tasks_assigned_resource1`(`assigned_resource1`),
    INDEX `jpi_tasks_assigned_resource2`(`assigned_resource2`),
    INDEX `jpi_tasks_assigned_resource_group1`(`assigned_resource_group1`),
    INDEX `jpi_tasks_assigned_resource_group2`(`assigned_resource_group2`),
    INDEX `jpi_tasks_model_type_model_id_index`(`model_type`, `model_id`),
    INDEX `jpi_tasks_processing_resource1`(`processing_resource1`),
    INDEX `jpi_tasks_processing_resource2`(`processing_resource2`),
    INDEX `jpi_tasks_processing_resource_group1`(`processing_resource_group1`),
    INDEX `jpi_tasks_processing_resource_group2`(`processing_resource_group2`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jpi_work_time_per_weekdays` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `jpi_resource_id` BIGINT UNSIGNED NOT NULL,
    `weekday` VARCHAR(255) NOT NULL,
    `work_time` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `jpi_work_time_per_weekdays_jpi_resource_id_foreign`(`jpi_resource_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `code` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `languages_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_classifications` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sort_order` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `machine_classifications_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_component_serial_number_profiles` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `serial_number_profile_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `machine_component_serial_number_profiles_machine_id_foreign`(`machine_id`),
    INDEX `machine_component_serial_number_profiles_snp_foreign`(`serial_number_profile_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_cycles` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `registered_datetime` DATETIME(0) NOT NULL,
    `quantity` INTEGER NOT NULL DEFAULT 1,
    `type` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `serial` VARCHAR(255) NULL,
    `batch` VARCHAR(255) NULL,
    `confirmed_datetime` DATETIME(0) NULL,

    INDEX `machine_cycles_machine_id_foreign`(`machine_id`),
    INDEX `machine_cycles_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_daily_expected_quantities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NULL,
    `item_id` BIGINT UNSIGNED NULL,
    `date` DATE NOT NULL,
    `quantity` DOUBLE NOT NULL,
    `te` DOUBLE NOT NULL DEFAULT 0,
    `tr` DOUBLE NOT NULL DEFAULT 0,
    `teardown_time` DOUBLE NOT NULL DEFAULT 0,
    `workloadable_type` VARCHAR(255) NULL,
    `workloadable_id` BIGINT UNSIGNED NULL,
    `shift_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `cavity` INTEGER NOT NULL DEFAULT 1,

    INDEX `machine_daily_expected_quantities_item_id_foreign`(`item_id`),
    INDEX `machine_daily_expected_quantities_machine_id_foreign`(`machine_id`),
    INDEX `machine_daily_expected_quantities_shift_id_foreign`(`shift_id`),
    INDEX `workloadable_idx`(`workloadable_type`, `workloadable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `just_plan_it_guid` VARCHAR(255) NULL,
    `lead_time_days` DOUBLE NOT NULL DEFAULT 0,
    `hall_id` BIGINT UNSIGNED NULL,
    `cost_center_id` BIGINT UNSIGNED NULL,
    `auto_assign_machine` BOOLEAN NOT NULL DEFAULT false,
    `default_te` DOUBLE NULL,
    `staging_area_id` BIGINT UNSIGNED NULL,
    `is_active` BOOLEAN NULL DEFAULT true,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `machine_groups_custom_id_unique`(`custom_id`),
    INDEX `machine_groups_cost_center_id_foreign`(`cost_center_id`),
    INDEX `machine_groups_hall_id_foreign`(`hall_id`),
    INDEX `machine_groups_staging_area_id_foreign`(`staging_area_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_last_serial_number_profiles` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `serial_number_profile_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `machine_last_serial_number_profiles_machine_id_foreign`(`machine_id`),
    INDEX `machine_last_serial_number_profiles_snp_foreign`(`serial_number_profile_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_machine_state_times` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `machine_state_id` BIGINT UNSIGNED NULL,
    `start` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `end` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `machine_machine_state_times_end_index`(`end`),
    INDEX `machine_machine_state_times_machine_id_foreign`(`machine_id`),
    INDEX `machine_machine_state_times_machine_id_index`(`machine_id`),
    INDEX `machine_machine_state_times_machine_state_id_foreign`(`machine_state_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_machine_states` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_state_id` BIGINT UNSIGNED NOT NULL,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `standard_value_key_activity_type_id` BIGINT UNSIGNED NULL,

    INDEX `machine_machine_states_svk_at_id_foreign`(`standard_value_key_activity_type_id`),
    INDEX `machine_state_machines_machine_id_foreign`(`machine_id`),
    INDEX `machine_state_machines_machine_state_id_foreign`(`machine_state_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_middle_serial_number_profiles` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `serial_number_profile_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `machine_middle_serial_number_profiles_machine_id_foreign`(`machine_id`),
    INDEX `machine_middle_serial_number_profiles_snp_foreign`(`serial_number_profile_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_process_data` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `registered_date` DATETIME(0) NOT NULL DEFAULT '2025-07-29 04:51:36',
    `digital_input_1` BOOLEAN NULL,
    `digital_input_2` BOOLEAN NULL,
    `digital_input_3` BOOLEAN NULL,
    `digital_input_4` BOOLEAN NULL,
    `digital_input_5` BOOLEAN NULL,
    `digital_input_6` BOOLEAN NULL,
    `digital_input_7` BOOLEAN NULL,
    `digital_input_8` BOOLEAN NULL,
    `analog_input_1` DOUBLE NULL,
    `analog_input_2` DOUBLE NULL,
    `analog_input_3` DOUBLE NULL,
    `analog_input_4` DOUBLE NULL,
    `analog_input_5` DOUBLE NULL,
    `analog_input_6` DOUBLE NULL,
    `analog_input_7` DOUBLE NULL,
    `analog_input_8` DOUBLE NULL,
    `analog_input_9` DOUBLE NULL,
    `analog_input_10` DOUBLE NULL,
    `analog_input_11` DOUBLE NULL,
    `analog_input_12` DOUBLE NULL,
    `analog_input_13` DOUBLE NULL,
    `analog_input_14` DOUBLE NULL,
    `analog_input_15` DOUBLE NULL,
    `analog_input_16` DOUBLE NULL,
    `analog_input_17` DOUBLE NULL,
    `analog_input_18` DOUBLE NULL,
    `analog_input_19` DOUBLE NULL,
    `analog_input_20` DOUBLE NULL,
    `text_input_1` VARCHAR(255) NULL,
    `text_input_2` VARCHAR(255) NULL,
    `text_input_3` VARCHAR(255) NULL,
    `text_input_4` VARCHAR(255) NULL,
    `text_input_5` VARCHAR(255) NULL,
    `text_input_6` VARCHAR(255) NULL,
    `text_input_7` VARCHAR(255) NULL,
    `text_input_8` VARCHAR(255) NULL,
    `text_input_9` VARCHAR(255) NULL,
    `text_input_10` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `text_input_11` VARCHAR(255) NULL,
    `text_input_12` VARCHAR(255) NULL,
    `text_input_13` VARCHAR(255) NULL,
    `text_input_14` VARCHAR(255) NULL,
    `text_input_15` VARCHAR(255) NULL,
    `text_input_16` VARCHAR(255) NULL,
    `text_input_17` VARCHAR(255) NULL,
    `text_input_18` VARCHAR(255) NULL,
    `text_input_19` VARCHAR(255) NULL,
    `text_input_20` VARCHAR(255) NULL,

    INDEX `machine_process_data_machine_id_foreign`(`machine_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_process_data_configurations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `machine_process_data_type` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `unit_of_measure_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sort_order` INTEGER NOT NULL DEFAULT 0,

    INDEX `machine_process_data_configurations_unit_of_measure_id_foreign`(`unit_of_measure_id`),
    UNIQUE INDEX `machine_data_config_unique`(`machine_id`, `machine_process_data_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_prod_order_pos_operation_times` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NOT NULL,
    `start` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `end` DATETIME(0) NULL,
    `cavity` DOUBLE NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `status` VARCHAR(255) NULL,
    `packaging_instruction_id` BIGINT UNSIGNED NULL,
    `item_id_packaging` BIGINT UNSIGNED NULL,
    `packaging_instruction_id_parent` BIGINT UNSIGNED NULL,
    `item_id_packaging_parent` BIGINT UNSIGNED NULL,
    `user_id_start` BIGINT UNSIGNED NULL,
    `user_id_end` BIGINT UNSIGNED NULL,

    INDEX `machine_prod_order_pos_operation_times_machine_id_foreign`(`machine_id`),
    INDEX `machine_prod_order_pos_operation_times_status_index`(`status`),
    INDEX `machine_prod_order_pos_operation_times_user_id_end_foreign`(`user_id_end`),
    INDEX `machine_prod_order_pos_operation_times_user_id_start_foreign`(`user_id_start`),
    INDEX `mpo_item_id_packaging_foreign`(`item_id_packaging`),
    INDEX `mpo_item_id_packaging_parent_foreign`(`item_id_packaging_parent`),
    INDEX `mpo_packaging_instruction_id_foreign`(`packaging_instruction_id`),
    INDEX `mpo_packaging_instruction_id_parent_foreign`(`packaging_instruction_id_parent`),
    INDEX `prod_order_pos_operation_id_foreign_for_operation_times`(`prod_order_pos_operation_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_registered_times` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `hours_split` DOUBLE NOT NULL,
    `machine_state_id` BIGINT UNSIGNED NULL,
    `status_operation` VARCHAR(255) NULL,
    `start` DATETIME(0) NULL,
    `end` DATETIME(0) NULL,
    `standard_value_key_activity_type_id` BIGINT UNSIGNED NULL,
    `is_generated` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `date` DATE NOT NULL,
    `shift_id` BIGINT UNSIGNED NULL,
    `is_exported` BOOLEAN NOT NULL DEFAULT false,

    INDEX `machine_registered_times_machine_id_foreign`(`machine_id`),
    INDEX `machine_registered_times_machine_state_id_foreign`(`machine_state_id`),
    INDEX `machine_registered_times_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `machine_registered_times_shift_id_foreign`(`shift_id`),
    INDEX `machine_registered_times_svk_activity_type_id_foreign`(`standard_value_key_activity_type_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_resource_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `resource_group_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `machine_resource_groups_resource_group_id_foreign`(`resource_group_id`),
    UNIQUE INDEX `machine_resource_groups_machine_id_resource_group_id_unique`(`machine_id`, `resource_group_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_state_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_productive` BOOLEAN NOT NULL DEFAULT false,
    `has_capacity` BOOLEAN NOT NULL DEFAULT true,
    `color` VARCHAR(6) NOT NULL DEFAULT '000000',
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `machine_state_groups_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_states` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `name` VARCHAR(255) NOT NULL,
    `machine_state_group_id` BIGINT UNSIGNED NOT NULL,
    `color` VARCHAR(6) NOT NULL DEFAULT '000000',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `state_type` VARCHAR(255) NOT NULL DEFAULT 'STANDSTILL',
    `is_quality_relevant` BOOLEAN NOT NULL DEFAULT false,
    `microstop_duration` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `machine_states_custom_id_unique`(`custom_id`),
    INDEX `machine_states_machine_state_group_id_foreign`(`machine_state_group_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_tasks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `task_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `machine_tasks_machine_id_foreign`(`machine_id`),
    INDEX `machine_tasks_task_id_foreign`(`task_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_user_plan_times` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `start_time` DATETIME(0) NOT NULL,
    `end_time` DATETIME(0) NOT NULL,
    `capacity_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `machine_user_plan_times_capacity_id_foreign`(`capacity_id`),
    INDEX `machine_user_plan_times_machine_id_foreign`(`machine_id`),
    INDEX `machine_user_plan_times_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_user_restrictions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `machine_user_restrictions_machine_id_foreign`(`machine_id`),
    INDEX `machine_user_restrictions_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machine_user_times` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `shift_id` BIGINT UNSIGNED NULL,
    `start` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `end` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `standard_value_key_activity_type_id` BIGINT UNSIGNED NULL,

    INDEX `machine_user_times_end_index`(`end`),
    INDEX `machine_user_times_machine_id_foreign`(`machine_id`),
    INDEX `machine_user_times_machine_id_index`(`machine_id`),
    INDEX `machine_user_times_shift_id_foreign`(`shift_id`),
    INDEX `machine_user_times_standard_value_key_activity_type_id_foreign`(`standard_value_key_activity_type_id`),
    INDEX `machine_user_times_user_id_foreign`(`user_id`),
    INDEX `machine_user_times_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `machines` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `usage_factor` DOUBLE NOT NULL DEFAULT 1,
    `hall_id` BIGINT UNSIGNED NULL,
    `machine_group_id` BIGINT UNSIGNED NULL,
    `tr` DOUBLE NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `price` DOUBLE NULL DEFAULT 0,
    `is_furnace` BOOLEAN NOT NULL DEFAULT false,
    `is_casting_machine` BOOLEAN NOT NULL DEFAULT false,
    `just_plan_it_guid` VARCHAR(255) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `cost_center_id` BIGINT UNSIGNED NULL,
    `price_changed_date` DATETIME(0) NULL,
    `status_board_card_type` VARCHAR(255) NOT NULL DEFAULT 'VIEW_1',
    `machine_board_type` VARCHAR(255) NOT NULL DEFAULT 'VIEW_1',
    `production_plan_type` VARCHAR(255) NOT NULL DEFAULT 'MANUAL',
    `confirmation_type` VARCHAR(255) NOT NULL DEFAULT 'MANUAL',
    `machine_state_type` VARCHAR(255) NOT NULL DEFAULT 'MANUAL',
    `tpm_sub_group_id` BIGINT UNSIGNED NULL,
    `has_operation_pool` BOOLEAN NOT NULL DEFAULT false,
    `hwe_cost_factor_type` VARCHAR(255) NULL,
    `lead_time_days` DOUBLE NOT NULL DEFAULT 0,
    `construction_year` YEAR NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `machine_board_hours` DOUBLE NOT NULL DEFAULT 12,
    `plant_id` BIGINT UNSIGNED NULL,
    `production_supply_area_id` BIGINT UNSIGNED NULL,
    `standard_value_key_id` BIGINT UNSIGNED NULL,
    `shift_model_id` BIGINT UNSIGNED NULL,
    `supports_parallel_operations` BOOLEAN NOT NULL DEFAULT true,
    `machine_state_id_default_production` BIGINT UNSIGNED NULL,
    `machine_state_id_default_off` BIGINT UNSIGNED NULL,
    `auto_packaging` BOOLEAN NOT NULL DEFAULT false,
    `auto_post_goods_receipt` BOOLEAN NOT NULL DEFAULT false,
    `host_iot_gateway` VARCHAR(255) NULL,
    `machine_board_state_type` VARCHAR(255) NULL,
    `requires_batch_management_middle` BOOLEAN NOT NULL DEFAULT true,
    `requires_batch_management_last` BOOLEAN NOT NULL DEFAULT true,
    `quantity_type` VARCHAR(255) NULL,
    `limit_quantity_to_packaging_target` BOOLEAN NOT NULL DEFAULT false,
    `host_node_red` VARCHAR(255) NULL,
    `printer_name` VARCHAR(255) NULL,
    `auto_close_operation` BOOLEAN NOT NULL DEFAULT false,
    `auto_print_middle_operation` BOOLEAN NOT NULL DEFAULT false,
    `sort_order` INTEGER NOT NULL DEFAULT 1000,
    `constraint_type` VARCHAR(255) NULL DEFAULT 'MANUAL',
    `needs_operator_for_production` BOOLEAN NOT NULL DEFAULT false,
    `save_operator_id` BOOLEAN NOT NULL DEFAULT false,
    `qualification_import_type` VARCHAR(255) NOT NULL DEFAULT 'NONE',
    `default_qualification_hours` DOUBLE NOT NULL DEFAULT 0,
    `default_qualification_operations` DOUBLE NOT NULL DEFAULT 0,
    `machine_state_id_default_setup` BIGINT UNSIGNED NULL,
    `machine_state_id_default_available` BIGINT UNSIGNED NULL,
    `save_operator_id_qualivisu` BOOLEAN NOT NULL DEFAULT false,
    `tpm_group_id` BIGINT UNSIGNED NULL,
    `allow_status_change_with_entry_exit` BOOLEAN NOT NULL DEFAULT false,
    `check_previous_operation_quantity` BOOLEAN NOT NULL DEFAULT false,
    `show_only_operations_with_previous_confirmed` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `machines_custom_id_unique`(`custom_id`),
    INDEX `machines_cost_center_id_foreign`(`cost_center_id`),
    INDEX `machines_hall_id_foreign`(`hall_id`),
    INDEX `machines_machine_group_id_foreign`(`machine_group_id`),
    INDEX `machines_machine_state_id_default_available_foreign`(`machine_state_id_default_available`),
    INDEX `machines_machine_state_id_default_off_foreign`(`machine_state_id_default_off`),
    INDEX `machines_machine_state_id_default_production_foreign`(`machine_state_id_default_production`),
    INDEX `machines_machine_state_id_default_setup_foreign`(`machine_state_id_default_setup`),
    INDEX `machines_plant_id_foreign`(`plant_id`),
    INDEX `machines_production_supply_area_id_foreign`(`production_supply_area_id`),
    INDEX `machines_shift_model_id_foreign`(`shift_model_id`),
    INDEX `machines_standard_value_key_id_foreign`(`standard_value_key_id`),
    INDEX `machines_tpm_group_id_foreign`(`tpm_group_id`),
    INDEX `machines_tpm_sub_group_id_foreign`(`tpm_sub_group_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `maintenance_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `maintenance_types_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `marker_recipe_pos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `marker_recipe_id` BIGINT UNSIGNED NOT NULL,
    `pos` INTEGER NULL,
    `marker_pos_type` VARCHAR(255) NOT NULL,
    `font_height` INTEGER NULL DEFAULT 0,
    `pos_x` INTEGER NULL DEFAULT 0,
    `pos_y` INTEGER NULL DEFAULT 0,
    `pos_z` INTEGER NULL DEFAULT 0,
    `angle` INTEGER NULL DEFAULT 0,
    `should_touch_probe` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `marker_recipe_pos_marker_recipe_id_pos_unique`(`marker_recipe_id`, `pos`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `marker_recipe_pos_blocks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `marker_recipe_pos_id` BIGINT UNSIGNED NOT NULL,
    `order` INTEGER NOT NULL,
    `marker_block_type` VARCHAR(255) NOT NULL,
    `date_time_format_string` VARCHAR(255) NULL,
    `text` VARCHAR(255) NULL,
    `ascii_dec` INTEGER NULL,
    `shot_counter_length` INTEGER NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `notes` VARCHAR(255) NULL,

    UNIQUE INDEX `marker_recipe_pos_blocks_marker_recipe_pos_id_order_unique`(`marker_recipe_pos_id`, `order`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `marker_recipes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `item_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `delay` INTEGER NULL DEFAULT 0,
    `zaxis` BOOLEAN NULL DEFAULT false,

    UNIQUE INDEX `marker_recipes_custom_id_unique`(`custom_id`),
    INDEX `marker_recipes_item_id_foreign`(`item_id`),
    INDEX `marker_recipes_machine_id_foreign`(`machine_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `market_segments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sort_order` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `market_segments_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `material_analyses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `regulation` VARCHAR(255) NULL,
    `issue_revision` VARCHAR(255) NOT NULL,
    `note` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `material_analyse_additional_id` VARCHAR(255) NULL,

    UNIQUE INDEX `material_analyses_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `material_analysis_chem_analyses` (
    `material_analysis_id` BIGINT UNSIGNED NOT NULL,
    `chem_analysis_id` BIGINT UNSIGNED NOT NULL,

    INDEX `material_analysis_chem_analyses_chem_analysis_id_foreign`(`chem_analysis_id`),
    INDEX `material_analysis_chem_analyses_material_analysis_id_foreign`(`material_analysis_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `material_analysis_material` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `material_analysis_id` BIGINT UNSIGNED NOT NULL,
    `material_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `mam_material_analysis_id_foreign`(`material_analysis_id`),
    INDEX `mam_materials_id_foreign`(`material_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `material_consumption_machines` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `material_consumption_id` BIGINT UNSIGNED NOT NULL,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `material_consumption_machines_machine_id_foreign`(`machine_id`),
    UNIQUE INDEX `mc_machines_mc_id_machine_id_unique`(`material_consumption_id`, `machine_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `material_consumptions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `furnace_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `quantity` DOUBLE NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `material_consumptions_furnace_id_foreign`(`furnace_id`),
    INDEX `material_consumptions_item_id_foreign`(`item_id`),
    INDEX `material_consumptions_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `material_databases` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `material_id` BIGINT UNSIGNED NULL,
    `heat_treatment` VARCHAR(255) NULL,
    `tensile_strength` VARCHAR(255) NULL,
    `temperature` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `hardness` DOUBLE NULL,
    `min_tensile_strength` DOUBLE NULL,
    `max_tensile_strength` DOUBLE NULL,

    UNIQUE INDEX `material_databases_custom_id_unique`(`custom_id`),
    INDEX `material_databases_material_id_foreign`(`material_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `materials` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `check_starting_material` BOOLEAN NOT NULL DEFAULT false,
    `note` VARCHAR(255) NULL,
    `density` DOUBLE NOT NULL,
    `material_group_type` VARCHAR(255) NOT NULL,
    `warehouse_material` VARCHAR(255) NOT NULL,
    `forging_temperature_min` INTEGER NULL,
    `forging_temperature_max` INTEGER NULL,
    `put_in_cold_oven` BOOLEAN NOT NULL DEFAULT false,
    `shrinkage` VARCHAR(255) NOT NULL DEFAULT 'ONE_AND_HALF_PERCENT',
    `color_type` VARCHAR(255) NULL,
    `warm_in_warm` BOOLEAN NULL,
    `cool_down_at_rest` BOOLEAN NULL,

    UNIQUE INDEX `materials_name_unique`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `measure_components` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `option_name` VARCHAR(255) NULL,
    `component_type` VARCHAR(255) NULL,
    `is_required` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `media` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `model_type` VARCHAR(255) NOT NULL,
    `model_id` BIGINT UNSIGNED NOT NULL,
    `uuid` CHAR(36) NULL,
    `collection_name` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `file_name` VARCHAR(255) NOT NULL,
    `mime_type` VARCHAR(255) NULL,
    `disk` VARCHAR(255) NOT NULL,
    `conversions_disk` VARCHAR(255) NULL,
    `size` BIGINT UNSIGNED NOT NULL,
    `manipulations` LONGTEXT NOT NULL,
    `custom_properties` LONGTEXT NOT NULL,
    `generated_conversions` LONGTEXT NOT NULL,
    `responsive_images` LONGTEXT NOT NULL,
    `order_column` INTEGER UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_selected` BOOLEAN NULL DEFAULT false,
    `history` LONGTEXT NULL,

    UNIQUE INDEX `media_uuid_unique`(`uuid`),
    INDEX `media_model_type_model_id_index`(`model_type`, `model_id`),
    INDEX `media_order_column_index`(`order_column`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `meeting_component_meeting_type` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `meeting_type_id` BIGINT UNSIGNED NOT NULL,
    `meeting_component_id` BIGINT UNSIGNED NOT NULL,
    `required_component` BOOLEAN NOT NULL DEFAULT false,
    `required_grid` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `meeting_component_meeting_type_meeting_component_id_foreign`(`meeting_component_id`),
    UNIQUE INDEX `mt_mt_component_unique`(`meeting_type_id`, `meeting_component_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `meeting_components` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `is_required_component` BOOLEAN NOT NULL DEFAULT false,
    `is_required_grid` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `meeting_components_name_unique`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `meeting_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `user_id_creator` BIGINT UNSIGNED NULL,
    `user_id_updated_by` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `meeting_types_custom_id_unique`(`custom_id`),
    INDEX `meeting_types_user_id_creator_foreign`(`user_id_creator`),
    INDEX `meeting_types_user_id_updated_by_foreign`(`user_id_updated_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `meeting_user` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `meeting_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `meeting_user_user_id_foreign`(`user_id`),
    UNIQUE INDEX `meeting_user_meeting_id_user_id_unique`(`meeting_id`, `user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `meetings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `description` LONGTEXT NULL,
    `date` TIMESTAMP(0) NULL,
    `type` VARCHAR(255) NOT NULL DEFAULT 'URGENT',
    `status` VARCHAR(255) NOT NULL DEFAULT 'ACTIVE',
    `user_id_creator` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `meeting_type_id` BIGINT UNSIGNED NULL,
    `place` LONGTEXT NULL,
    `meeting_with` LONGTEXT NULL,
    `is_regular` BOOLEAN NOT NULL DEFAULT false,
    `user_id_updated_by` BIGINT UNSIGNED NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `customer_id` BIGINT UNSIGNED NULL,
    `supplier_id` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `meetings_custom_id_unique`(`custom_id`),
    INDEX `meetings_customer_id_foreign`(`customer_id`),
    INDEX `meetings_machine_id_foreign`(`machine_id`),
    INDEX `meetings_meeting_type_id_foreign`(`meeting_type_id`),
    INDEX `meetings_supplier_id_foreign`(`supplier_id`),
    INDEX `meetings_user_id_creator_foreign`(`user_id_creator`),
    INDEX `meetings_user_id_updated_by_foreign`(`user_id_updated_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `message_read` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `message_id` BIGINT UNSIGNED NOT NULL,
    `read` BOOLEAN NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `message_read_message_id_foreign`(`message_id`),
    INDEX `message_read_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `messages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `chat_id` BIGINT UNSIGNED NOT NULL,
    `sender_user_id` BIGINT UNSIGNED NULL,
    `content` TEXT NOT NULL,
    `chat_action` VARCHAR(255) NULL,
    `affected_user_id` BIGINT UNSIGNED NULL,
    `read_by_all` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `messages_affected_user_id_foreign`(`affected_user_id`),
    INDEX `messages_chat_id_foreign`(`chat_id`),
    INDEX `messages_sender_user_id_foreign`(`sender_user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `metallographies` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `regulation` VARCHAR(255) NOT NULL,
    `issue_revision` VARCHAR(255) NOT NULL,
    `grain_size` VARCHAR(255) NULL,
    `grain_size_after_carburizing` VARCHAR(255) NULL,
    `grain_size_determination_according_to` VARCHAR(255) NULL,
    `grain_size_textfield` VARCHAR(255) NULL,
    `cleanliness_determination` VARCHAR(255) NULL,
    `cleanliness_50602_astma45_sep1570` VARCHAR(255) NULL,
    `cleanliness_textfield` VARCHAR(255) NULL,
    `a_fine` DOUBLE NULL,
    `a_coarse` DOUBLE NULL,
    `b_fine` DOUBLE NULL,
    `b_coarse` DOUBLE NULL,
    `c_fine` DOUBLE NULL,
    `c_coarse` DOUBLE NULL,
    `d_fine` DOUBLE NULL,
    `d_coarse` DOUBLE NULL,
    `ds` DOUBLE NULL,
    `image` BOOLEAN NOT NULL DEFAULT false,
    `needs_microsection_structure` BOOLEAN NOT NULL DEFAULT false,
    `needs_microsection_grain_size` BOOLEAN NOT NULL DEFAULT false,
    `needs_microsection_carburized` BOOLEAN NOT NULL DEFAULT false,
    `needs_microsection_cleanliness` BOOLEAN NOT NULL DEFAULT false,
    `microstructure_assessment` VARCHAR(255) NULL,
    `microstructure_quota` VARCHAR(255) NULL,
    `microstructure_max_quota` DOUBLE NULL,
    `microstructure_textfield` VARCHAR(255) NULL,
    `needs_ic_according_to` VARCHAR(255) NULL,
    `needs_ic_simulation_annealing` BOOLEAN NOT NULL DEFAULT false,
    `needs_ic_external_testing` BOOLEAN NOT NULL DEFAULT false,
    `needs_ic_textfield` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `offer_note` VARCHAR(255) NULL,
    `cleanliness_max_value` DOUBLE NULL,
    `grain_size_value` DOUBLE NULL,
    `wb_parameter` DOUBLE NULL,

    UNIQUE INDEX `metallographies_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `metallography_cleanliness_determination_accordings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `metallography_id` BIGINT UNSIGNED NOT NULL,
    `cleanliness_determination_according_to` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `metallo_id_clean_deter_accord_to_index`(`metallography_id`, `cleanliness_determination_according_to`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `migrations` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `migration` VARCHAR(255) NOT NULL,
    `batch` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `model_has_permissions` (
    `permission_id` BIGINT UNSIGNED NOT NULL,
    `model_type` VARCHAR(255) NOT NULL,
    `model_id` BIGINT UNSIGNED NOT NULL,

    INDEX `model_has_permissions_model_id_model_type_index`(`model_id`, `model_type`),
    PRIMARY KEY (`permission_id`, `model_id`, `model_type`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `model_has_roles` (
    `role_id` BIGINT UNSIGNED NOT NULL,
    `model_type` VARCHAR(255) NOT NULL,
    `model_id` BIGINT UNSIGNED NOT NULL,

    INDEX `model_has_roles_model_id_model_type_index`(`model_id`, `model_type`),
    PRIMARY KEY (`role_id`, `model_id`, `model_type`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mp_cost_machines` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `mp_cost_id` BIGINT UNSIGNED NOT NULL,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `mp_cost_machines_machine_id_foreign`(`machine_id`),
    UNIQUE INDEX `mp_cost_machines_mp_cost_id_machine_id_unique`(`mp_cost_id`, `machine_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mp_costs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `cost_group` VARCHAR(255) NOT NULL,
    `cost_sub_group` VARCHAR(255) NOT NULL,
    `cost_type` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mp_materials` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `density` DOUBLE NOT NULL,
    `price` DOUBLE NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `price_changed_date` DATETIME(0) NULL,

    UNIQUE INDEX `mp_materials_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mp_offer_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `mp_offer_id` BIGINT UNSIGNED NULL,
    `description` VARCHAR(255) NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `log_date` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `project_order` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `mp_offer_logs_mp_offer_id_foreign`(`mp_offer_id`),
    INDEX `mp_offer_logs_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mp_offer_pos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `mp_offer_id` BIGINT UNSIGNED NULL,
    `mp_costs_id` BIGINT UNSIGNED NULL,
    `cost_group` VARCHAR(255) NULL,
    `cost_sub_group` VARCHAR(255) NULL,
    `cost_type` VARCHAR(255) NULL,
    `name` VARCHAR(255) NULL,
    `length` DOUBLE NULL,
    `width` DOUBLE NULL,
    `height` DOUBLE NULL,
    `mp_material_id` BIGINT UNSIGNED NULL,
    `price` DOUBLE NULL,
    `total` DOUBLE NULL,
    `density` DOUBLE NULL,
    `quantity` DOUBLE NULL,
    `supplier_offer_id` VARCHAR(255) NULL,
    `supplier_offer_date` VARCHAR(255) NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `machine_quantity` DOUBLE NULL,
    `machine_price` DOUBLE NULL,
    `personnel_quantity` DOUBLE NULL,
    `personnel_price` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `mouldflow_type` VARCHAR(255) NULL,
    `pf_pm_type` VARCHAR(255) NULL,
    `supplier_id` BIGINT UNSIGNED NULL,
    `note` VARCHAR(255) NULL,

    INDEX `mp_offer_pos_machine_id_foreign`(`machine_id`),
    INDEX `mp_offer_pos_mp_costs_id_foreign`(`mp_costs_id`),
    INDEX `mp_offer_pos_mp_material_id_foreign`(`mp_material_id`),
    INDEX `mp_offer_pos_mp_offer_id_foreign`(`mp_offer_id`),
    INDEX `mp_offer_pos_supplier_id_foreign`(`supplier_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mp_offers` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NULL,
    `date` DATE NULL,
    `customer_id` BIGINT UNSIGNED NULL,
    `final_customer_id` BIGINT UNSIGNED NULL,
    `tool_type` VARCHAR(255) NULL,
    `name` VARCHAR(255) NULL,
    `is_closed` BOOLEAN NULL DEFAULT false,
    `construction_type` VARCHAR(255) NULL,
    `press_weight` DOUBLE NULL DEFAULT 0,
    `quantity_imprint` VARCHAR(255) NULL DEFAULT '0',
    `max_length` DOUBLE NULL DEFAULT 0,
    `max_width` DOUBLE NULL DEFAULT 0,
    `max_height` DOUBLE NULL DEFAULT 0,
    `weight` DOUBLE NULL DEFAULT 0,
    `length` DOUBLE NULL DEFAULT 0,
    `width` DOUBLE NULL DEFAULT 0,
    `height` DOUBLE NULL DEFAULT 0,
    `size` DOUBLE NULL DEFAULT 0,
    `projected_area` DOUBLE NULL DEFAULT 0,
    `imprint_volume` DOUBLE NULL DEFAULT 0,
    `material` VARCHAR(255) NULL,
    `shots_guaranteed` DOUBLE NULL DEFAULT 0,
    `finishing_visible` VARCHAR(255) NULL,
    `finishing_not_visible` VARCHAR(255) NULL,
    `injection_type` VARCHAR(255) NULL,
    `nozzle_quantity` DOUBLE NULL DEFAULT 0,
    `nozzle_type` VARCHAR(255) NULL,
    `rubber_injection` VARCHAR(255) NULL,
    `has_movements` BOOLEAN NULL DEFAULT false,
    `movements_mechanic` VARCHAR(255) NULL DEFAULT '0',
    `movements_hydraulic` VARCHAR(255) NULL DEFAULT '0',
    `rods` VARCHAR(255) NULL DEFAULT '0',
    `jowls` VARCHAR(255) NULL DEFAULT '0',
    `unscrewing` VARCHAR(255) NULL DEFAULT '0',
    `has_third_plate` BOOLEAN NULL DEFAULT false,
    `has_double_extraction` BOOLEAN NULL DEFAULT false,
    `extraction_type` VARCHAR(255) NULL,
    `is_rounded_extractor` BOOLEAN NULL DEFAULT false,
    `is_tear_extractor` BOOLEAN NULL DEFAULT false,
    `is_tubular_extractor` BOOLEAN NULL DEFAULT false,
    `is_square_extractor` BOOLEAN NULL DEFAULT false,
    `is_extraction_help_fixed` BOOLEAN NULL DEFAULT false,
    `is_hydraulic_extraction_fixed` BOOLEAN NULL DEFAULT false,
    `has_laths_rings` BOOLEAN NULL DEFAULT false,
    `surplus_material` DOUBLE NULL DEFAULT 0,
    `surplus_external` DOUBLE NULL DEFAULT 0,
    `surplus_internal` DOUBLE NULL DEFAULT 0,
    `surplus_total` DOUBLE NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `mp_offer_type` VARCHAR(255) NULL,
    `injection_type_2` VARCHAR(255) NULL,
    `nozzle_quantity_2` DOUBLE NULL DEFAULT 0,
    `nozzle_type_2` VARCHAR(255) NULL,
    `injection_note` VARCHAR(255) NULL,
    `note` LONGTEXT NULL,
    `version` INTEGER NULL DEFAULT 0,
    `project_nr` VARCHAR(255) NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `is_cloned` BOOLEAN NULL DEFAULT false,
    `is_saved` BOOLEAN NULL DEFAULT false,
    `surplus_internal_personnel` DOUBLE NULL DEFAULT 0,
    `surplus_internal_machine` DOUBLE NULL DEFAULT 0,
    `parent_offer_id` BIGINT UNSIGNED NULL,

    INDEX `mp_offers_customer_id_foreign`(`customer_id`),
    INDEX `mp_offers_final_customer_id_foreign`(`final_customer_id`),
    INDEX `mp_offers_parent_offer_id_foreign`(`parent_offer_id`),
    INDEX `mp_offers_user_id_foreign`(`user_id`),
    UNIQUE INDEX `mp_offers_unique_index`(`custom_id`, `version`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mp_personnels` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `cost_sub_group` VARCHAR(255) NULL,
    `price` DOUBLE NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `price_changed_date` DATETIME(0) NULL,

    UNIQUE INDEX `mp_personnels_custom_id_unique`(`custom_id`),
    UNIQUE INDEX `mp_personnels_cost_sub_group_unique`(`cost_sub_group`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mt_norm_control_units` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `mt_norm_id` BIGINT UNSIGNED NOT NULL,
    `control_unit` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `mt_norm_control_units_mt_norm_id_control_unit_index`(`mt_norm_id`, `control_unit`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mt_norms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `specification` VARCHAR(255) NULL,
    `revision` VARCHAR(255) NULL,
    `test_class` VARCHAR(255) NULL,
    `testing_facility` VARCHAR(255) NULL,
    `test_equipment` VARCHAR(255) NULL,
    `uv_lamp` VARCHAR(255) NULL,
    `test_range` VARCHAR(255) NULL,
    `magnetization` VARCHAR(255) NULL,
    `current_type` VARCHAR(255) NULL,
    `illuminance` VARCHAR(255) NULL,
    `irradiance` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `registration_limit` VARCHAR(255) NULL,
    `lux_meter` VARCHAR(255) NULL,
    `field_strength_meter` VARCHAR(255) NULL,
    `uv_meter` VARCHAR(255) NULL,
    `comments` VARCHAR(255) NULL,
    `residual_magnetism` VARCHAR(255) NULL,
    `residual_magnetism_unit` VARCHAR(255) NULL,
    `control_unit` VARCHAR(255) NULL,

    UNIQUE INDEX `mt_norms_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mt_specs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `tensile_test_rt` BOOLEAN NOT NULL DEFAULT false,
    `reh_min` DOUBLE NULL,
    `reh_max` DOUBLE NULL,
    `rp_min` DOUBLE NULL,
    `rp_max` DOUBLE NULL,
    `rm_min` DOUBLE NULL,
    `rm_max` DOUBLE NULL,
    `a5_min` DOUBLE NULL,
    `a4_min` DOUBLE NULL,
    `z_min` DOUBLE NULL,
    `rp_rm_ratio` DOUBLE NULL,
    `text_tensile_test` VARCHAR(255) NULL,
    `tensile_test_warm` BOOLEAN NOT NULL DEFAULT false,
    `temperature` DOUBLE NULL,
    `rp_min_warm` DOUBLE NULL,
    `rm_min_warm` DOUBLE NULL,
    `a_min_warm` DOUBLE NULL,
    `z_min_warm` DOUBLE NULL,
    `impact_test` BOOLEAN NOT NULL DEFAULT false,
    `impact_test_type` VARCHAR(255) NULL,
    `impact_temperature_1` DOUBLE NULL,
    `impact_temperature_2` DOUBLE NULL,
    `impact_single_1` DOUBLE NULL,
    `impact_avg_1` DOUBLE NULL,
    `impact_single_2` DOUBLE NULL,
    `impact_avg_2` DOUBLE NULL,
    `hbw_min` DOUBLE NULL,
    `hbw_max` DOUBLE NULL,
    `mpa_min_piece` DOUBLE NULL,
    `mpa_max_piece` DOUBLE NULL,
    `mpa_min_specimen` DOUBLE NULL,
    `mpa_max_specimen` DOUBLE NULL,
    `hardness_test` BOOLEAN NOT NULL DEFAULT false,
    `hardness_conversion` VARCHAR(255) NULL,
    `hardness_test_type` VARCHAR(255) NULL,
    `hardness_localisation` VARCHAR(255) NULL,
    `hardness_min` DOUBLE NULL,
    `hardness_max` DOUBLE NULL,
    `bending_test` BOOLEAN NOT NULL DEFAULT false,
    `iso_7438` BOOLEAN NOT NULL DEFAULT false,
    `astm_a370` BOOLEAN NOT NULL DEFAULT false,
    `jominy_test` BOOLEAN NOT NULL DEFAULT false,
    `jominy_specification` VARCHAR(255) NULL,
    `j_1_5_min` DOUBLE NULL,
    `j_1_5_max` DOUBLE NULL,
    `j_3_min` DOUBLE NULL,
    `j_3_max` DOUBLE NULL,
    `j_5_min` DOUBLE NULL,
    `j_5_max` DOUBLE NULL,
    `j_7_min` DOUBLE NULL,
    `j_7_max` DOUBLE NULL,
    `j_9_min` DOUBLE NULL,
    `j_9_max` DOUBLE NULL,
    `j_10_min` DOUBLE NULL,
    `j_10_max` DOUBLE NULL,
    `j_11_min` DOUBLE NULL,
    `j_11_max` DOUBLE NULL,
    `j_13_min` DOUBLE NULL,
    `j_13_max` DOUBLE NULL,
    `j_15_min` DOUBLE NULL,
    `j_15_max` DOUBLE NULL,
    `j_20_min` DOUBLE NULL,
    `j_20_max` DOUBLE NULL,
    `j_25_min` DOUBLE NULL,
    `j_25_max` DOUBLE NULL,
    `j_30_min` DOUBLE NULL,
    `j_30_max` DOUBLE NULL,
    `j_35_min` DOUBLE NULL,
    `j_35_max` DOUBLE NULL,
    `j_40_min` DOUBLE NULL,
    `j_40_max` DOUBLE NULL,
    `j_45_min` DOUBLE NULL,
    `j_45_max` DOUBLE NULL,
    `j_50_min` DOUBLE NULL,
    `j_50_max` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `mt_specs_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `non_destructive_norms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `non_destructive_testing_id` BIGINT UNSIGNED NOT NULL,
    `norm_type` VARCHAR(255) NOT NULL,
    `norm_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `non_destructive_norms_non_destructive_testing_id_unique`(`non_destructive_testing_id`),
    INDEX `non_destructive_norms_norm_type_norm_id_index`(`norm_type`, `norm_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `non_destructive_testing_attestation_entities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `non_destructive_testing_id` BIGINT UNSIGNED NOT NULL,
    `attestation_entity` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `non_destructive_testing_id_attestation_entity_index`(`non_destructive_testing_id`, `attestation_entity`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `non_destructive_testing_surface_attestation_entities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `non_destructive_testing_id` BIGINT UNSIGNED NOT NULL,
    `attestation_entity` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `non_dest_test_id_surface_attestation_entity_index`(`non_destructive_testing_id`, `attestation_entity`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `non_destructive_testings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `non_destructive_testing` VARCHAR(255) NOT NULL,
    `ultrasound_output` VARCHAR(255) NULL,
    `ultrasound_test_scope` VARCHAR(255) NULL,
    `ultrasound_test_range` VARCHAR(255) NULL,
    `ultrasound_efg_max` DOUBLE NULL,
    `ultrasound_attenuation` BOOLEAN NOT NULL DEFAULT false,
    `ultrasound_details` VARCHAR(255) NULL,
    `max_residual_field_strength` DOUBLE NULL,
    `max_residual_field_strength_unit` VARCHAR(255) NULL,
    `surface_crack_test_method` VARCHAR(255) NULL,
    `surface_crack_output` VARCHAR(255) NULL,
    `surface_crack_test_criteria` VARCHAR(255) NULL,
    `surface_crack_audit_scope` VARCHAR(255) NULL,
    `surface_crack_details` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `us_norm_id` BIGINT UNSIGNED NULL,
    `offer_note` VARCHAR(255) NULL,
    `surface_non_destructive_testing` VARCHAR(255) NULL,

    UNIQUE INDEX `non_destructive_testings_custom_id_unique`(`custom_id`),
    INDEX `non_destructive_testings_us_norm_id_foreign`(`us_norm_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `norm_chem_analyses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `norm_id` BIGINT UNSIGNED NOT NULL,
    `chem_analyses_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `norm_chem_analyses_chem_analyses_id_foreign`(`chem_analyses_id`),
    INDEX `norm_chem_analyses_norm_id_foreign`(`norm_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `norms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `material_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `note` VARCHAR(255) NULL,

    UNIQUE INDEX `norms_custom_id_unique`(`custom_id`),
    INDEX `norms_material_id_foreign`(`material_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `notification_group_email_addresses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `notification_group_id` BIGINT UNSIGNED NOT NULL,
    `email_address` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `notification_group_email_addresses_notification_group_id_foreign`(`notification_group_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `notification_group_notification_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `notification_group_id` BIGINT UNSIGNED NULL,
    `notification_type` VARCHAR(255) NOT NULL DEFAULT 'ABSENCE_APPROVAL',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `notification_group_notification_types_fk`(`notification_group_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `notification_group_users` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `notification_group_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `notification_group_users_notification_group_id_foreign`(`notification_group_id`),
    INDEX `notification_group_users_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `notification_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `notification_groups_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `offer_pos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `offer_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NOT NULL,
    `item_id` BIGINT UNSIGNED NULL,
    `item_name` VARCHAR(255) NULL,
    `product_type` VARCHAR(255) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `drawing_id` VARCHAR(255) NULL,
    `attachments` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_commission` BOOLEAN NOT NULL DEFAULT false,
    `material_id` BIGINT UNSIGNED NULL,
    `outer_diameter_final` DOUBLE NULL,
    `side_a_final` DOUBLE NULL,
    `to_be_defined` DOUBLE NULL,
    `side_b_final` DOUBLE NULL,
    `inner_diameter_final` DOUBLE NULL,
    `height_final` DOUBLE NULL,
    `length_final` DOUBLE NULL,
    `customer_material_number` VARCHAR(255) NULL,
    `delivery_state` VARCHAR(255) NOT NULL,
    `outer_diameter_surface_final` VARCHAR(255) NULL,
    `side_a_surface_final` VARCHAR(255) NULL,
    `side_b_surface_final` VARCHAR(255) NULL,
    `inner_diameter_surface_final` VARCHAR(255) NULL,
    `height_surface_final` VARCHAR(255) NULL,
    `length_surface_final` VARCHAR(255) NULL,
    `min_allowance_outer_diameter_final` DOUBLE NULL,
    `max_allowance_outer_diameter_final` DOUBLE NULL,
    `min_allowance_side_a_final` DOUBLE NULL,
    `max_allowance_side_a_final` DOUBLE NULL,
    `min_allowance_side_b_final` DOUBLE NULL,
    `max_allowance_side_b_final` DOUBLE NULL,
    `min_allowance_inner_diameter_final` DOUBLE NULL,
    `max_allowance_inner_diameter_final` DOUBLE NULL,
    `min_allowance_height_final` DOUBLE NULL,
    `max_allowance_height_final` DOUBLE NULL,
    `min_allowance_length_final` DOUBLE NULL,
    `max_allowance_length_final` DOUBLE NULL,
    `is_rejected` BOOLEAN NOT NULL DEFAULT false,
    `rejection_type` VARCHAR(255) NULL,
    `crm_id` VARCHAR(255) NULL,
    `total_length` DOUBLE NULL,
    `max_outer_diameter` DOUBLE NULL,
    `length_encore_info` DOUBLE NULL,
    `outer_diameter_encore_info` DOUBLE NULL,
    `outer_diameter_lower_tolerance` DOUBLE NULL,
    `outer_diameter_upper_tolerance` DOUBLE NULL,
    `length_lower_tolerance` DOUBLE NULL,
    `length_upper_tolerance` DOUBLE NULL,
    `is_specification_needed` BOOLEAN NOT NULL DEFAULT false,
    `status` VARCHAR(255) NOT NULL DEFAULT 'AV',
    `rust_protection_type` VARCHAR(255) NULL,
    `tool_id` BIGINT UNSIGNED NULL,
    `outer_tolerance` VARCHAR(255) NULL,
    `inner_tolerance` VARCHAR(255) NULL,
    `side_a_tolerance` VARCHAR(255) NULL,
    `side_b_tolerance` VARCHAR(255) NULL,
    `height_tolerance` VARCHAR(255) NULL,
    `length_tolerance` VARCHAR(255) NULL,
    `has_no_contour` BOOLEAN NOT NULL DEFAULT false,
    `has_mechanical_drilling` BOOLEAN NULL DEFAULT false,
    `drilling_diameter` DOUBLE NULL,
    `show_mechanical_values` BOOLEAN NOT NULL DEFAULT false,
    `check_text` BOOLEAN NOT NULL DEFAULT false,
    `offer_pos_id_copy_from` BIGINT UNSIGNED NULL,
    `has_forged_drilling` BOOLEAN NOT NULL DEFAULT false,
    `is_extruded` BOOLEAN NOT NULL DEFAULT false,
    `is_hollow_punching` BOOLEAN NOT NULL DEFAULT false,
    `tool_id_2` BIGINT UNSIGNED NULL,
    `tool_id_3` BIGINT UNSIGNED NULL,
    `radial_width` DOUBLE NOT NULL,
    `max_inner_diameter` DOUBLE NULL,
    `is_exporting` BOOLEAN NOT NULL DEFAULT false,
    `offer_pos_available_batch_id` BIGINT UNSIGNED NULL,

    INDEX `offer_pos_item_id_foreign`(`item_id`),
    INDEX `offer_pos_material_id_foreign`(`material_id`),
    INDEX `offer_pos_offer_id_pos_index`(`offer_id`, `pos`),
    INDEX `offer_pos_offer_pos_id_copy_from_foreign`(`offer_pos_id_copy_from`),
    INDEX `offer_pos_tool_id_2_foreign`(`tool_id_2`),
    INDEX `offer_pos_tool_id_3_foreign`(`tool_id_3`),
    INDEX `offer_pos_tool_id_foreign`(`tool_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `offer_pos_available_batches` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `offer_pos_id` BIGINT UNSIGNED NOT NULL,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `batch` VARCHAR(255) NOT NULL,
    `is_OK` BOOLEAN NOT NULL DEFAULT true,

    INDEX `offer_pos_available_batches_item_id_foreign`(`item_id`),
    INDEX `offer_pos_available_batches_offer_pos_id_foreign`(`offer_pos_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `offer_pos_costs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `offer_pos_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NULL,
    `cost` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `quantity` DOUBLE NULL,
    `factor` DOUBLE NULL DEFAULT 1,
    `price` DOUBLE NULL,
    `lead_time_days` INTEGER NULL DEFAULT 0,
    `hwe_cost_calc_type` VARCHAR(255) NOT NULL DEFAULT 'PIECE',
    `group_type` VARCHAR(255) NOT NULL DEFAULT 'MANUAL',
    `unit` VARCHAR(255) NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `operation_plan_pos_id` BIGINT UNSIGNED NULL,

    INDEX `offer_pos_costs_machine_id_foreign`(`machine_id`),
    INDEX `offer_pos_costs_offer_pos_id_foreign`(`offer_pos_id`),
    INDEX `offer_pos_costs_operation_plan_pos_id_foreign`(`operation_plan_pos_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `offer_pos_dimension_shaft_upset_parts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `offer_pos_raw_dimension_id` BIGINT UNSIGNED NOT NULL,
    `type` VARCHAR(255) NULL,
    `section` INTEGER NULL,
    `length` DOUBLE NULL,
    `outer_diameter_start` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `outer_diameter_end` DOUBLE NULL,
    `side` DOUBLE NULL,
    `oversize` DOUBLE NULL,
    `is_sample` BOOLEAN NOT NULL DEFAULT false,
    `cold_outer_diameter` DOUBLE NULL,
    `warm_length` DOUBLE NULL,

    INDEX `offer_pos_raw_dimension_id_foreign`(`offer_pos_raw_dimension_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `offer_pos_dimension_upset_part_forged_beams` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `offer_pos_raw_dimension_id` BIGINT UNSIGNED NOT NULL,
    `type` VARCHAR(255) NULL,
    `section` INTEGER NULL,
    `length` DOUBLE NULL,
    `outer_diameter` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `cold_outer_diameter` DOUBLE NULL,
    `warm_length` DOUBLE NULL,
    `oversize` DOUBLE NULL,

    INDEX `offer_pos_raw_dimension_id_forged_beams_foreign`(`offer_pos_raw_dimension_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `offer_pos_mechanical_processes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `offer_pos_id` BIGINT UNSIGNED NOT NULL,
    `section` INTEGER NOT NULL,
    `outer_diameter` DOUBLE NULL,
    `inner_diameter` DOUBLE NULL,
    `length` DOUBLE NULL,
    `radius` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `side` DOUBLE NULL,
    `inner_length` DOUBLE NULL,
    `inner_radius` DOUBLE NULL,

    INDEX `offer_pos_mechanical_processes_offer_pos_id_foreign`(`offer_pos_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `offer_pos_prod_order_pos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `offer_pos_id` BIGINT UNSIGNED NULL,
    `prod_order_pos_id` BIGINT UNSIGNED NULL,

    INDEX `offer_pos_prod_order_pos_offer_pos_id_foreign`(`offer_pos_id`),
    INDEX `offer_pos_prod_order_pos_prod_order_pos_id_foreign`(`prod_order_pos_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `offer_pos_raw_dimensions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `offer_pos_id` BIGINT UNSIGNED NOT NULL,
    `outer_diameter` DOUBLE NULL,
    `side_a` DOUBLE NULL,
    `inner_diameter` DOUBLE NULL,
    `height` DOUBLE NULL,
    `length` DOUBLE NULL,
    `side_b` DOUBLE NULL,
    `outer_diameter_disk_punched` DOUBLE NULL,
    `inner_diameter_pre_1` DOUBLE NULL,
    `height_pre_1` DOUBLE NULL,
    `inner_diameter_pre_2` DOUBLE NULL,
    `height_pre_2` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `gross_weight` DOUBLE NULL,
    `operating_weight` DOUBLE NOT NULL,
    `semi_finished_product` DOUBLE NULL,
    `deformation` DOUBLE NULL,
    `semi_finished_product_type` VARCHAR(255) NULL,
    `quantity_raw_piece` INTEGER NULL,
    `quantity_final_for_raw` INTEGER NULL,
    `is_rolled` BOOLEAN NOT NULL DEFAULT false,
    `outer_diameter_pre_1` DOUBLE NULL,
    `outer_diameter_pre_2` DOUBLE NULL,
    `inner_diameter_hollow` DOUBLE NULL,
    `stretching_pin_value` INTEGER NULL,
    `rolling_pin_value` INTEGER NULL,
    `slug_height` DOUBLE NULL,
    `radial_width_pre_1` DOUBLE NULL,
    `height_to_radial_width_pre_1` DOUBLE NULL,
    `radial_width` DOUBLE NULL,
    `radial_width_pre_2` DOUBLE NULL,
    `slug_dm` DOUBLE NULL,
    `slug_weight` DOUBLE NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `machine_id_2` BIGINT UNSIGNED NULL,
    `round_min_dma` DOUBLE NULL,
    `round_min_dmb` DOUBLE NULL,
    `round_max_dma` DOUBLE NULL,
    `round_max_dmb` DOUBLE NULL,
    `square_min_dma` DOUBLE NULL,
    `square_min_dmb` DOUBLE NULL,
    `square_max_dma` DOUBLE NULL,
    `square_max_dmb` DOUBLE NULL,
    `octagon_min_swa` DOUBLE NULL,
    `octagon_min_swb` DOUBLE NULL,
    `octagon_max_swa` DOUBLE NULL,
    `octagon_max_swb` DOUBLE NULL,
    `material_forging_degree_total` DOUBLE NULL,
    `rolling_path` DOUBLE NULL,
    `axial_difference` DOUBLE NULL,
    `radial_width_per_100_mm` DOUBLE NULL,
    `height_to_radial_width` DOUBLE NULL,
    `rolling_path_rollweg` DOUBLE NULL,
    `rolling_pin` DOUBLE NULL,
    `shape` VARCHAR(255) NULL,
    `messages` TEXT NULL,
    `machine_id_3` BIGINT UNSIGNED NULL,
    `machine_id_4` BIGINT UNSIGNED NULL,
    `single_length` VARCHAR(255) NULL,
    `insert` VARCHAR(255) NULL,
    `pre_punching_1` DOUBLE NULL,
    `pre_punching_2` DOUBLE NULL,
    `pre_punching_3` DOUBLE NULL,
    `rolling_pin_1` DOUBLE NULL,
    `rolling_pin_2` DOUBLE NULL,
    `rolling_length` DOUBLE NULL,
    `rollback` VARCHAR(255) NULL,
    `excess_total_length` DOUBLE NULL,
    `stretching_path` DOUBLE NULL,
    `rollweg` DOUBLE NULL,
    `outer_end` VARCHAR(255) NULL,
    `outer_diameter_pre_1_warm` DOUBLE NULL,
    `outer_diameter_pre_2_warm` DOUBLE NULL,
    `inner_diameter_pre_1_warm` DOUBLE NULL,
    `inner_diameter_pre_2_warm` DOUBLE NULL,
    `height_pre_1_warm` DOUBLE NULL,
    `height_pre_2_warm` DOUBLE NULL,
    `forged_beam_value_1` VARCHAR(255) NULL,
    `forged_beam_value_2` VARCHAR(255) NULL,
    `forged_beam_value_3` DOUBLE NULL,
    `forged_beam_value_4` DOUBLE NULL,
    `forged_beam_value_5` DOUBLE NULL,
    `forged_beam_value_6` DOUBLE NULL,
    `forged_beam_value_7` DOUBLE NULL,
    `forged_beam_value_8` DOUBLE NULL,
    `forged_beam_text_1` VARCHAR(255) NULL,
    `forged_beam_text_2` VARCHAR(255) NULL,
    `machine_id_5` BIGINT UNSIGNED NULL,
    `expense` DOUBLE NULL,
    `disk_puch_round_a_min` VARCHAR(255) NULL,
    `disk_puch_square_a_min` VARCHAR(255) NULL,
    `disk_puch_octagon_a_min` VARCHAR(255) NULL,
    `disk_puch_round_a_max` VARCHAR(255) NULL,
    `disk_puch_square_a_max` VARCHAR(255) NULL,
    `disk_puch_octagon_a_max` VARCHAR(255) NULL,
    `disk_puch_round_l_min` VARCHAR(255) NULL,
    `disk_puch_square_l_min` VARCHAR(255) NULL,
    `disk_puch_octagon_l_min` VARCHAR(255) NULL,
    `disk_puch_round_l_max` VARCHAR(255) NULL,
    `disk_puch_square_l_max` VARCHAR(255) NULL,
    `disk_puch_octagon_l_max` VARCHAR(255) NULL,
    `disk_puch_round_optimal` VARCHAR(255) NULL,
    `disk_puch_square_optimal` VARCHAR(255) NULL,
    `disk_puch_octagon_optimal` VARCHAR(255) NULL,

    INDEX `offer_pos_raw_dimensions_machine_id_2_foreign`(`machine_id_2`),
    INDEX `offer_pos_raw_dimensions_machine_id_3_foreign`(`machine_id_3`),
    INDEX `offer_pos_raw_dimensions_machine_id_4_foreign`(`machine_id_4`),
    INDEX `offer_pos_raw_dimensions_machine_id_5_foreign`(`machine_id_5`),
    INDEX `offer_pos_raw_dimensions_machine_id_foreign`(`machine_id`),
    INDEX `offer_pos_raw_dimensions_offer_pos_id_foreign`(`offer_pos_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `offers` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `sales_opportunity_id` BIGINT UNSIGNED NULL,
    `customer_id` BIGINT UNSIGNED NULL,
    `contact_person` VARCHAR(255) NULL,
    `request_date` DATE NULL,
    `offer_until_date` DATE NULL,
    `customer_reference` VARCHAR(255) NULL,
    `type` VARCHAR(255) NULL,
    `additional_info` VARCHAR(255) NULL,
    `changes` VARCHAR(255) NULL,
    `is_short_offer` BOOLEAN NOT NULL DEFAULT false,
    `is_specification_necessary` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `status` VARCHAR(255) NULL,
    `phase` VARCHAR(255) NULL,
    `crm_id` VARCHAR(255) NULL,
    `updated_by` BIGINT UNSIGNED NULL,
    `is_package_price` BOOLEAN NOT NULL DEFAULT false,
    `sales_note` VARCHAR(255) NULL,
    `version` INTEGER NULL,
    `delivery_term_id` BIGINT UNSIGNED NULL,
    `country_id` BIGINT UNSIGNED NULL,
    `postal_code` VARCHAR(255) NULL,
    `destination` VARCHAR(255) NULL,
    `sales_group_id` BIGINT UNSIGNED NULL,
    `sales_area_id` BIGINT UNSIGNED NULL,
    `is_exporting` BOOLEAN NOT NULL DEFAULT false,

    INDEX `offers_country_id_foreign`(`country_id`),
    INDEX `offers_customer_id_foreign`(`customer_id`),
    INDEX `offers_delivery_term_id_foreign`(`delivery_term_id`),
    INDEX `offers_sales_area_id_foreign`(`sales_area_id`),
    INDEX `offers_sales_group_id_foreign`(`sales_group_id`),
    INDEX `offers_sales_opportunity_id_foreign`(`sales_opportunity_id`),
    INDEX `offers_updated_by_foreign`(`updated_by`),
    UNIQUE INDEX `offers_custom_id_version_unique`(`custom_id`, `version`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `only_office_sessions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id_creator` BIGINT UNSIGNED NOT NULL,
    `file_key` VARCHAR(255) NOT NULL,
    `file_name` VARCHAR(255) NOT NULL,
    `file_type` VARCHAR(255) NOT NULL,
    `extension` VARCHAR(255) NOT NULL,
    `parent_type` VARCHAR(255) NOT NULL,
    `parent_id` BIGINT UNSIGNED NOT NULL,
    `is_completed` BOOLEAN NOT NULL DEFAULT false,
    `confirmed_save` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `only_office_sessions_file_key_unique`(`file_key`),
    INDEX `only_office_sessions_parent_type_parent_id_index`(`parent_type`, `parent_id`),
    INDEX `only_office_sessions_user_id_creator_foreign`(`user_id_creator`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `operation_control_profiles` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `confirmation_type` VARCHAR(255) NULL,
    `auto_post_goods_receipt` BOOLEAN NOT NULL DEFAULT false,
    `external_processing_type` VARCHAR(255) NULL,

    UNIQUE INDEX `operation_control_profiles_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `operation_plan_pos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `operation_plan_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `te` DOUBLE NULL,
    `tr` DOUBLE NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `machine_group_id` BIGINT UNSIGNED NULL,
    `operation_code` VARCHAR(255) NULL,
    `is_warm_in_warm` BOOLEAN NOT NULL DEFAULT false,
    `unit` VARCHAR(255) NULL,
    `is_imported` BOOLEAN NULL DEFAULT false,
    `lead_time_days` DOUBLE NOT NULL DEFAULT 5,
    `cavity` INTEGER NULL DEFAULT 1,
    `alloy` VARCHAR(255) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,

    INDEX `operation_plan_pos_machine_group_id_foreign`(`machine_group_id`),
    INDEX `operation_plan_pos_machine_id_foreign`(`machine_id`),
    UNIQUE INDEX `operation_plan_pos_operation_plan_id_pos_unique`(`operation_plan_id`, `pos`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `operation_plan_pos_heat_treatments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `operation_plan_pos_id` BIGINT UNSIGNED NOT NULL,
    `quenching_medium` VARCHAR(255) NULL,
    `hardness` DOUBLE NULL,
    `temperature_min` DOUBLE NULL,
    `temperature_max` DOUBLE NULL,
    `annealing_temperature` DOUBLE NULL,
    `internal_note` VARCHAR(255) NULL,
    `heating_time` DOUBLE NULL,
    `holding_time` DOUBLE NULL,
    `cross_section` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `cooldown_rate` VARCHAR(255) NULL,

    INDEX `operation_plan_pos_heat_treatments_operation_plan_pos_id_foreign`(`operation_plan_pos_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `operation_plans` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NULL,
    `item_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_imported` BOOLEAN NULL DEFAULT false,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `name` VARCHAR(255) NULL,

    UNIQUE INDEX `operation_plans_custom_id_unique`(`custom_id`),
    INDEX `operation_plans_item_id_foreign`(`item_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `packaging_instruction_pos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `packaging_instruction_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NOT NULL,
    `packable_type` VARCHAR(255) NOT NULL,
    `packable_id` BIGINT UNSIGNED NOT NULL,
    `is_container` BOOLEAN NOT NULL DEFAULT false,
    `target_quantity` DOUBLE NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `unit_of_measure_id` BIGINT UNSIGNED NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,

    INDEX `packaging_instruction_pos_packable_type_packable_id_index`(`packable_type`, `packable_id`),
    INDEX `packaging_instruction_pos_packaging_instruction_id_foreign`(`packaging_instruction_id`),
    INDEX `packaging_instruction_pos_unit_of_measure_id_foreign`(`unit_of_measure_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `packaging_instructions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `uuid` VARCHAR(255) NULL,
    `machine_stop_type` VARCHAR(255) NOT NULL DEFAULT 'NO_STOP',
    `is_default` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `packaging_instructions_custom_id_unique`(`custom_id`),
    UNIQUE INDEX `packaging_instructions_uuid_unique`(`uuid`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `password_resets` (
    `email` VARCHAR(255) NOT NULL,
    `token` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,

    INDEX `password_resets_email_index`(`email`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `payment_terms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `name2` VARCHAR(255) NULL,
    `is_active` BOOLEAN NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `discount` DOUBLE NOT NULL DEFAULT 0,

    UNIQUE INDEX `payment_terms_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `permissions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `guard_name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `permissions_name_guard_name_unique`(`name`, `guard_name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `personal_access_tokens` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tokenable_type` VARCHAR(255) NOT NULL,
    `tokenable_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `token` VARCHAR(64) NOT NULL,
    `abilities` TEXT NULL,
    `last_used_at` TIMESTAMP(0) NULL,
    `expires_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `personal_access_tokens_token_unique`(`token`),
    INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type`, `tokenable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plan_visu_color_scheme_sortings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `plan_visu_color_scheme_id` BIGINT UNSIGNED NOT NULL,
    `sorting` INTEGER NOT NULL,
    `model_type` VARCHAR(255) NOT NULL,
    `model_column` VARCHAR(255) NOT NULL,
    `value_string` VARCHAR(255) NOT NULL,
    `color` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `has_border` BOOLEAN NULL DEFAULT false,
    `border_color` VARCHAR(255) NULL,
    `title_color` VARCHAR(255) NULL DEFAULT 'FFFFFF',
    `title` VARCHAR(255) NULL,

    INDEX `fk_plan_visu_color_scheme_id_value`(`plan_visu_color_scheme_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plan_visu_color_schemes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `plan_visu_color_schemes_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plan_visu_working_days_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `day` VARCHAR(255) NOT NULL,
    `is_working_day` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plants` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `item_state_id_default` BIGINT UNSIGNED NOT NULL DEFAULT 1,
    `hu_requires_container_item` BOOLEAN NOT NULL DEFAULT false,
    `is_shift_for_clockin_required` BOOLEAN NOT NULL DEFAULT true,
    `item_id_packaging_rework` BIGINT UNSIGNED NULL,
    `item_id_packaging_scrap` BIGINT UNSIGNED NULL,
    `storage_location_id_rework` BIGINT UNSIGNED NULL,
    `storage_location_id_scrap` BIGINT UNSIGNED NULL,
    `auto_post_goods_receipt_scrap` BOOLEAN NOT NULL DEFAULT false,
    `prod_order_pos_operation_id_indirect` BIGINT UNSIGNED NULL,
    `qualivisu_block_threshold` INTEGER NOT NULL DEFAULT 0,
    `qualivisu_shift_check_offset` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `plants_custom_id_unique`(`custom_id`),
    INDEX `plants_item_id_packaging_rework_foreign`(`item_id_packaging_rework`),
    INDEX `plants_item_id_packaging_scrap_foreign`(`item_id_packaging_scrap`),
    INDEX `plants_item_state_id_default_foreign`(`item_state_id_default`),
    INDEX `plants_prod_order_pos_operation_id_indirect_foreign`(`prod_order_pos_operation_id_indirect`),
    INDEX `plants_storage_location_id_rework_foreign`(`storage_location_id_rework`),
    INDEX `plants_storage_location_id_scrap_foreign`(`storage_location_id_scrap`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `potential_classifications` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sort_order` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `potential_classifications_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `printers` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `brand` VARCHAR(255) NULL,
    `model` VARCHAR(255) NULL,
    `ip_address` VARCHAR(45) NOT NULL,
    `port` INTEGER NOT NULL,
    `request_type` VARCHAR(255) NULL,
    `protocol` VARCHAR(255) NULL,
    `language` VARCHAR(255) NULL,
    `serial_nr` VARCHAR(255) NULL,
    `a4_type` VARCHAR(255) NULL,
    `a5_type` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_inspection_operation_resources` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `prod_inspection_operation_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NULL,
    `equipment_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `type` VARCHAR(255) NOT NULL DEFAULT 'EQUIPMENT',
    `external_id` VARCHAR(255) NULL,

    INDEX `prod_inspection_operation_resources_equipment_id_foreign`(`equipment_id`),
    UNIQUE INDEX `pior_unique`(`prod_inspection_operation_id`, `pos`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_inspection_operations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `frequency` VARCHAR(255) NOT NULL,
    `is_blocking` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `internal_id` VARCHAR(255) NULL,
    `name` VARCHAR(255) NULL,
    `interval_cycles` INTEGER NULL,
    `interval_seconds` INTEGER NULL,
    `capacity_id_last_point` BIGINT UNSIGNED NULL,
    `inspection_plan_id` BIGINT UNSIGNED NULL,

    INDEX `prod_inspection_operations_capacity_id_last_point_foreign`(`capacity_id_last_point`),
    INDEX `prod_inspection_operations_inspection_plan_id_foreign`(`inspection_plan_id`),
    UNIQUE INDEX `operation_pos_unique`(`prod_order_pos_operation_id`, `pos`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_lots` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `start` DATETIME(0) NULL,
    `end` DATETIME(0) NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `note` VARCHAR(255) NULL,
    `temperature` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
    `is_cooldown_needed` BOOLEAN NOT NULL DEFAULT false,
    `real_cooling_rate` VARCHAR(255) NULL,

    UNIQUE INDEX `prod_lots_custom_id_unique`(`custom_id`),
    INDEX `prod_lots_machine_id_foreign`(`machine_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NOT NULL,
    `item_id` BIGINT UNSIGNED NULL,
    `start` DATETIME(0) NULL,
    `end` DATETIME(0) NULL,
    `quantity` DOUBLE NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `just_plan_it_guid` VARCHAR(255) NULL,
    `sales_order_pos_id` BIGINT UNSIGNED NULL,
    `calculation_id` BIGINT UNSIGNED NULL,
    `status` VARCHAR(255) NULL,
    `raw_material` VARCHAR(255) NULL,
    `release_date` DATETIME(0) NULL,
    `is_production_possible` BOOLEAN NULL DEFAULT false,
    `user_id_creator` BIGINT UNSIGNED NULL,
    `user_id_responsible` BIGINT UNSIGNED NULL,
    `estimated_hours` DOUBLE NULL DEFAULT 0,
    `notes` LONGTEXT NULL,
    `label` VARCHAR(255) NULL DEFAULT 'INTERNAL',
    `due_date` DATETIME(0) NULL,
    `storage_location_id` BIGINT UNSIGNED NULL,
    `unit_of_measure_id` BIGINT UNSIGNED NULL,
    `status_erp` VARCHAR(255) NULL,
    `status_plan` VARCHAR(255) NULL,
    `batch` VARCHAR(255) NULL,
    `actual_time` VARCHAR(255) NULL,
    `cost` INTEGER NULL DEFAULT 0,
    `supplier_id_tool` BIGINT UNSIGNED NULL,
    `is_sampling_required` BOOLEAN NULL DEFAULT false,
    `is_sampling_done` BOOLEAN NULL DEFAULT false,
    `is_prod_date_manual` BOOLEAN NULL DEFAULT true,
    `is_tool_blocked` BOOLEAN NULL DEFAULT false,
    `is_sampling_successful` BOOLEAN NULL DEFAULT false,
    `equipment_id` BIGINT UNSIGNED NULL,
    `storage_location_id_rework` BIGINT UNSIGNED NULL,
    `storage_location_id_scrap` BIGINT UNSIGNED NULL,

    INDEX `prod_order_pos_calculation_id_foreign`(`calculation_id`),
    INDEX `prod_order_pos_equipment_id_foreign`(`equipment_id`),
    INDEX `prod_order_pos_item_id_foreign`(`item_id`),
    INDEX `prod_order_pos_item_index`(`item_id`),
    INDEX `prod_order_pos_sales_order_pos_id_foreign`(`sales_order_pos_id`),
    INDEX `prod_order_pos_storage_location_id_foreign`(`storage_location_id`),
    INDEX `prod_order_pos_storage_location_id_rework_foreign`(`storage_location_id_rework`),
    INDEX `prod_order_pos_storage_location_id_scrap_foreign`(`storage_location_id_scrap`),
    INDEX `prod_order_pos_supplier_id_tool_foreign`(`supplier_id_tool`),
    INDEX `prod_order_pos_unit_of_measure_id_foreign`(`unit_of_measure_id`),
    INDEX `prod_order_pos_user_id_creator_foreign`(`user_id_creator`),
    INDEX `prod_order_pos_user_id_responsible_foreign`(`user_id_responsible`),
    UNIQUE INDEX `prod_order_pos_prod_order_id_pos_unique`(`prod_order_id`, `pos`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos_bom_pos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NOT NULL,
    `item_id` BIGINT UNSIGNED NULL,
    `qty_for_one_parent` DOUBLE NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `unit_of_measure_id` BIGINT UNSIGNED NULL,
    `batch` VARCHAR(255) NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(255) NULL,
    `warehouse_id` BIGINT UNSIGNED NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `storage_location_id` BIGINT UNSIGNED NULL,
    `is_backflush` BOOLEAN NOT NULL DEFAULT true,
    `is_quantity_fixed` BOOLEAN NOT NULL DEFAULT false,
    `quantity_total` DOUBLE NOT NULL DEFAULT 0,
    `is_bulk` BOOLEAN NOT NULL DEFAULT false,
    `item_type` VARCHAR(4) NULL,
    `reference_document` VARCHAR(255) NULL,
    `storage_bin_id` BIGINT UNSIGNED NULL,
    `item_number` VARCHAR(255) NULL,
    `warehouse_process_type` VARCHAR(255) NULL,
    `stock_type` VARCHAR(255) NULL,
    `entitled_to_dispose_party` VARCHAR(255) NULL,
    `stock_owner` VARCHAR(255) NULL,
    `component_preparation_state` VARCHAR(255) NULL DEFAULT 'NOT_PREPARED',
    `is_available` BOOLEAN NOT NULL DEFAULT false,

    INDEX `prod_order_pos_bom_pos_item_id_foreign`(`item_id`),
    INDEX `prod_order_pos_bom_pos_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `prod_order_pos_bom_pos_prod_order_pos_operation_id_index`(`prod_order_pos_operation_id`),
    INDEX `prod_order_pos_bom_pos_storage_bin_id_foreign`(`storage_bin_id`),
    INDEX `prod_order_pos_bom_pos_storage_location_id_foreign`(`storage_location_id`),
    INDEX `prod_order_pos_bom_pos_unit_of_measure_id_foreign`(`unit_of_measure_id`),
    INDEX `prod_order_pos_bom_pos_warehouse_id_foreign`(`warehouse_id`),
    UNIQUE INDEX `prod_order_pos_bom_pos_prod_order_pos_id_pos_unique`(`prod_order_pos_id`, `pos`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos_operation_alt_machines` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NOT NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `te` DOUBLE NULL,
    `reference_nr` BIGINT NULL,

    INDEX `prod_order_pos_operation_alt_machines_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `prod_order_pos_operation_alt_machines_machine_id_foreign`(`machine_id`),
    UNIQUE INDEX `unique_pos_prod_order_pos_operation_id_alt_mach`(`pos`, `prod_order_pos_operation_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos_operation_batches` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `batch` VARCHAR(255) NOT NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `type` VARCHAR(255) NOT NULL DEFAULT 'CONSUMPTION',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,

    INDEX `prod_order_pos_operation_batches_machine_id_foreign`(`machine_id`),
    UNIQUE INDEX `p_o_p_o_b_unique`(`prod_order_pos_operation_id`, `batch`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos_operation_confirmations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `shift_id` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `prod_order_pos_operation_confirmations_custom_id_unique`(`custom_id`),
    INDEX `prod_order_pos_operation_confirmations_shift_id_foreign`(`shift_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos_operation_consumptions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NOT NULL,
    `prod_order_pos_operation_quantity_id` BIGINT UNSIGNED NULL,
    `quantity` DOUBLE NOT NULL DEFAULT 1,
    `serial` VARCHAR(255) NULL,
    `batch` VARCHAR(255) NULL,
    `consumed_datetime` DATETIME(0) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `unit_of_measure_id` BIGINT UNSIGNED NULL,
    `storage_location_id` BIGINT UNSIGNED NULL,
    `handling_unit_id` BIGINT UNSIGNED NULL,
    `item_state_id` BIGINT UNSIGNED NOT NULL,
    `item_plant_id` BIGINT UNSIGNED NOT NULL,
    `warehouse_id` BIGINT UNSIGNED NULL,
    `storage_bin_id` BIGINT UNSIGNED NULL,
    `production_supply_area_id` BIGINT UNSIGNED NULL,
    `manually_changed` BOOLEAN NOT NULL DEFAULT false,
    `note` VARCHAR(255) NULL,
    `prod_order_pos_operation_confirmation_id` BIGINT UNSIGNED NULL,

    INDEX `popoq_id_foreign_for_popo_consumptions`(`prod_order_pos_operation_quantity_id`),
    INDEX `prod_order_consumptions_psa_id_foreign`(`production_supply_area_id`),
    INDEX `prod_order_consumptions_storage_location_id_foreign`(`storage_location_id`),
    INDEX `prod_order_pos_operation_consumptions_handling_unit_id_foreign`(`handling_unit_id`),
    INDEX `prod_order_pos_operation_consumptions_item_plant_id_foreign`(`item_plant_id`),
    INDEX `prod_order_pos_operation_consumptions_item_state_id_foreign`(`item_state_id`),
    INDEX `prod_order_pos_operation_consumptions_p_o_p_o_c_id_foreign`(`prod_order_pos_operation_confirmation_id`),
    INDEX `prod_order_pos_operation_consumptions_storage_bin_id_foreign`(`storage_bin_id`),
    INDEX `prod_order_pos_operation_consumptions_unit_of_measure_id_foreign`(`unit_of_measure_id`),
    INDEX `prod_order_pos_operation_consumptions_warehouse_id_foreign`(`warehouse_id`),
    INDEX `prod_order_pos_operation_id_foreign_for_popo_consumptions`(`prod_order_pos_operation_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos_operation_deliveries` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `quantity` INTEGER NOT NULL DEFAULT 0,
    `is_completed` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `prod_order_pos_operation_deliveries_user_id_foreign`(`user_id`),
    INDEX `prod_order_pos_operation_id_foreign_for_operation_deliveries`(`prod_order_pos_operation_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos_operation_handling_units` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `handling_unit_id` BIGINT UNSIGNED NOT NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `type` VARCHAR(255) NOT NULL DEFAULT 'PROD_GOOD',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `prod_order_pos_operation_handling_units_handling_unit_id_foreign`(`handling_unit_id`),
    INDEX `prod_order_pos_operation_handling_units_machine_id_foreign`(`machine_id`),
    UNIQUE INDEX `p_o_p_o_h_u_unique`(`prod_order_pos_operation_id`, `handling_unit_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos_operation_loaded_quantities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NOT NULL,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `quantity` DOUBLE NOT NULL DEFAULT 0,
    `date` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `user_id` BIGINT UNSIGNED NULL,
    `is_unloaded` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `loaded_quantities_machine_id_foreign`(`machine_id`),
    INDEX `loaded_quantities_prod_order_pos_op_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `loaded_quantities_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos_operation_quantities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `item_state_id` BIGINT UNSIGNED NOT NULL,
    `quantity` DOUBLE NOT NULL,
    `confirmed_datetime` DATETIME(0) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `serial` VARCHAR(255) NULL,
    `batch` VARCHAR(255) NULL,
    `prod_order_pos_operation_quantity_id_canceled` BIGINT UNSIGNED NULL,
    `is_final_quantity` BOOLEAN NOT NULL DEFAULT false,
    `post_goods_receipt` BOOLEAN NOT NULL DEFAULT false,
    `prod_order_pos_operation_confirmation_id` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `prod_order_pos_operation_quantities_canceled_unique`(`prod_order_pos_operation_quantity_id_canceled`),
    INDEX `prod_order_pos_operation_id_foreign_for_operation_quantities`(`prod_order_pos_operation_id`),
    INDEX `prod_order_pos_operation_quantities_item_state_id_foreign`(`item_state_id`),
    INDEX `prod_order_pos_operation_quantities_machine_id_foreign`(`machine_id`),
    INDEX `prod_order_pos_operation_quantities_p_o_p_o_c_id_foreign`(`prod_order_pos_operation_confirmation_id`),
    INDEX `prod_order_pos_operation_quantities_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos_operation_resource_times` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NOT NULL,
    `equipment_id` BIGINT UNSIGNED NOT NULL,
    `equipment_id_parent` BIGINT UNSIGNED NULL,
    `start` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `end` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `fk_eq_parent`(`equipment_id_parent`),
    INDEX `fk_pos_op_id`(`prod_order_pos_operation_id`),
    INDEX `prod_order_pos_operation_resource_times_equipment_id_foreign`(`equipment_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos_operation_resources` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NOT NULL,
    `item_id_tool` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `reference_nr` INTEGER NULL,
    `equipment_id` BIGINT UNSIGNED NULL,

    INDEX `prod_order_pos_operation_resources_equipment_id_foreign`(`equipment_id`),
    INDEX `prod_order_pos_operation_resources_item_id_tool_foreign`(`item_id_tool`),
    INDEX `prod_order_pos_operation_resources_operation_id_foreign`(`prod_order_pos_operation_id`),
    UNIQUE INDEX `unique_pos_prod_order_pos_operation_id`(`pos`, `prod_order_pos_operation_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos_operation_unloaded_quantities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NOT NULL,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `prod_order_pos_operation_loaded_quantity_id` BIGINT UNSIGNED NULL,
    `quantity` DOUBLE NOT NULL DEFAULT 0,
    `date` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `user_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `unloaded_quantities_loaded_quantity_foreign`(`prod_order_pos_operation_loaded_quantity_id`),
    INDEX `unloaded_quantities_machine_id_foreign`(`machine_id`),
    INDEX `unloaded_quantities_prod_order_pos_op_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `unloaded_quantities_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos_operations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `start` DATETIME(0) NULL,
    `end` DATETIME(0) NULL,
    `te` DOUBLE NOT NULL DEFAULT 0,
    `tr` DOUBLE NOT NULL DEFAULT 0,
    `plan_tr` DOUBLE NULL,
    `erp_tr` DOUBLE NULL,
    `cavity` INTEGER NOT NULL DEFAULT 1,
    `plan_cavity` INTEGER NULL,
    `erp_cavity` INTEGER NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `tool_id` BIGINT UNSIGNED NULL,
    `registered_quantity` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `status` VARCHAR(255) NULL,
    `comment` VARCHAR(255) NULL,
    `show_in_planvisu` BOOLEAN NOT NULL DEFAULT true,
    `erp_start` DATETIME(0) NULL,
    `erp_end` DATETIME(0) NULL,
    `plan_start` DATETIME(0) NULL,
    `plan_end` DATETIME(0) NULL,
    `plan_te` DOUBLE NULL,
    `erp_te` DOUBLE NULL,
    `plan_machine_id` BIGINT UNSIGNED NULL,
    `erp_machine_id` BIGINT UNSIGNED NULL,
    `machine_group_id` BIGINT UNSIGNED NULL,
    `is_changed` BOOLEAN NOT NULL DEFAULT false,
    `user_group_id` BIGINT UNSIGNED NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `operation_code` VARCHAR(255) NULL,
    `prod_lot_id` BIGINT UNSIGNED NULL,
    `resource_group_id` BIGINT UNSIGNED NULL,
    `send_ahead_quantity` DOUBLE NULL DEFAULT 0,
    `transfer_time` INTEGER NOT NULL DEFAULT 0,
    `operation_start_date_v10` DATETIME(0) NULL,
    `is_urgent_delivery` BOOLEAN NOT NULL DEFAULT false,
    `component_availability` VARCHAR(255) NULL,
    `plan_component_availability` VARCHAR(255) NULL,
    `erp_component_availability` VARCHAR(255) NULL,
    `operator_usage_factor` DOUBLE NULL DEFAULT 1,
    `teardown_time` INTEGER NULL,
    `plan_teardown_time` INTEGER NULL,
    `erp_teardown_time` INTEGER NULL,
    `has_labels_prepared` BOOLEAN NOT NULL DEFAULT false,
    `note` LONGTEXT NULL,
    `resource_group_id_erp` BIGINT UNSIGNED NULL,
    `resource_group_id_plan` BIGINT UNSIGNED NULL,
    `operation_plan_id_origin` BIGINT UNSIGNED NULL,
    `operation_plan_pos_id_origin` BIGINT UNSIGNED NULL,
    `is_repair_completed` BOOLEAN NOT NULL DEFAULT false,
    `repair_completed_date` DATETIME(0) NULL,
    `plant_id_production` BIGINT UNSIGNED NULL,
    `quantity` DOUBLE NOT NULL DEFAULT 0,
    `operation_control_profile_id` BIGINT UNSIGNED NULL,
    `unit_of_measure_id` BIGINT UNSIGNED NULL,
    `status_erp` VARCHAR(255) NULL,
    `status_plan` VARCHAR(255) NULL,
    `operation_close_date_v10` DATETIME(0) NULL,
    `tool_insert_id` BIGINT UNSIGNED NULL,
    `ict_babtec` VARCHAR(255) NULL,
    `operation_code_erp` VARCHAR(255) NULL,
    `operation_code_plan` VARCHAR(255) NULL,
    `tool_reference_nr_erp` BIGINT NULL,
    `tool_reference_nr` BIGINT NULL,
    `has_components_prepared` BOOLEAN NOT NULL DEFAULT false,
    `ict_prodid` VARCHAR(255) NULL,
    `item_id_tool` BIGINT UNSIGNED NULL,
    `item_id_tool_insert` BIGINT UNSIGNED NULL,
    `lead_time_days` DOUBLE NULL DEFAULT 0,
    `constraint_type` VARCHAR(255) NULL DEFAULT 'MANUAL',
    `is_automatic_created_repair` BOOLEAN NULL DEFAULT false,
    `heads` INTEGER NOT NULL DEFAULT 1,
    `heads_erp` INTEGER NULL,
    `heads_plan` INTEGER NULL,
    `alloy` VARCHAR(255) NULL,

    INDEX `prod_order_pos_op_plan_pos_erp_machine_id_foreign`(`erp_machine_id`),
    INDEX `prod_order_pos_op_plan_pos_machine_group_id_foreign`(`machine_group_id`),
    INDEX `prod_order_pos_op_plan_pos_machine_id_foreign`(`machine_id`),
    INDEX `prod_order_pos_op_plan_pos_plan_machine_id_foreign`(`plan_machine_id`),
    INDEX `prod_order_pos_op_plan_pos_tool_id_foreign`(`tool_id`),
    INDEX `prod_order_pos_operations_item_id_tool_foreign`(`item_id_tool`),
    INDEX `prod_order_pos_operations_item_id_tool_insert_foreign`(`item_id_tool_insert`),
    INDEX `prod_order_pos_operations_machine_id_index`(`machine_id`),
    INDEX `prod_order_pos_operations_operation_control_profile_id_foreign`(`operation_control_profile_id`),
    INDEX `prod_order_pos_operations_operation_plan_id_origin_foreign`(`operation_plan_id_origin`),
    INDEX `prod_order_pos_operations_operation_plan_pos_id_origin_foreign`(`operation_plan_pos_id_origin`),
    INDEX `prod_order_pos_operations_plant_id_production_foreign`(`plant_id_production`),
    INDEX `prod_order_pos_operations_prod_lot_id_foreign`(`prod_lot_id`),
    INDEX `prod_order_pos_operations_resource_group_id_erp_foreign`(`resource_group_id_erp`),
    INDEX `prod_order_pos_operations_resource_group_id_foreign`(`resource_group_id`),
    INDEX `prod_order_pos_operations_resource_group_id_plan_foreign`(`resource_group_id_plan`),
    INDEX `prod_order_pos_operations_status_index`(`status`),
    INDEX `prod_order_pos_operations_tool_insert_id_index`(`tool_insert_id`),
    INDEX `prod_order_pos_operations_unit_of_measure_id_foreign`(`unit_of_measure_id`),
    INDEX `prod_order_pos_operations_user_group_id_foreign`(`user_group_id`),
    INDEX `prod_order_pos_operations_user_id_foreign`(`user_id`),
    UNIQUE INDEX `prod_order_pos_op_plan_pos_prod_order_pos_id_pos_unique`(`prod_order_pos_id`, `pos`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_pos_serials` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `serial` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `prod_order_pos_id` BIGINT UNSIGNED NOT NULL,
    `is_suspended` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `prod_order_pos_serials_prod_order_pos_id_serial_unique`(`prod_order_pos_id`, `serial`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_order_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `prod_order_types_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prod_orders` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `assembly` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `document_date` DATE NULL,
    `production_register` VARCHAR(255) NULL,
    `order_type` VARCHAR(255) NOT NULL DEFAULT 'PRODUCTION',
    `plant_id_production` BIGINT UNSIGNED NULL,
    `is_closed` BOOLEAN NOT NULL DEFAULT false,
    `plant_id` BIGINT UNSIGNED NULL,
    `call_off_id` BIGINT UNSIGNED NULL,
    `customer_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(255) NULL,
    `maintenance_type_id` BIGINT UNSIGNED NULL,
    `prod_order_type_id` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `prod_orders_custom_id_unique`(`custom_id`),
    INDEX `prod_orders_call_off_id_foreign`(`call_off_id`),
    INDEX `prod_orders_customer_id_foreign`(`customer_id`),
    INDEX `prod_orders_maintenance_type_id_foreign`(`maintenance_type_id`),
    INDEX `prod_orders_plant_id_foreign`(`plant_id`),
    INDEX `prod_orders_plant_id_production_foreign`(`plant_id_production`),
    INDEX `prod_orders_prod_order_type_id_foreign`(`prod_order_type_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `production_supply_areas` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `plant_id` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `production_supply_areas_custom_id_unique`(`custom_id`),
    INDEX `production_supply_areas_plant_id_foreign`(`plant_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `project_phases` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `description` LONGTEXT NULL,
    `comment` LONGTEXT NULL,
    `start` DATE NULL,
    `end` DATE NULL,
    `completion` DOUBLE NOT NULL DEFAULT 0,
    `is_archive` BOOLEAN NOT NULL DEFAULT false,
    `parent_id` BIGINT UNSIGNED NULL,
    `task_priority_id` BIGINT UNSIGNED NULL,
    `project_id` BIGINT UNSIGNED NOT NULL,
    `user_id_responsible` BIGINT UNSIGNED NULL,
    `user_id_creator` BIGINT UNSIGNED NULL,
    `user_id_updated_by` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `project_phases_custom_id_unique`(`custom_id`),
    INDEX `project_phases_parent_id_foreign`(`parent_id`),
    INDEX `project_phases_project_id_foreign`(`project_id`),
    INDEX `project_phases_task_priority_id_foreign`(`task_priority_id`),
    INDEX `project_phases_user_id_creator_foreign`(`user_id_creator`),
    INDEX `project_phases_user_id_responsible_foreign`(`user_id_responsible`),
    INDEX `project_phases_user_id_updated_by_foreign`(`user_id_updated_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `project_steering_committee` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `project_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `project_steering_committee_project_id_foreign`(`project_id`),
    INDEX `project_steering_committee_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `project_team_member` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `project_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `project_team_member_project_id_foreign`(`project_id`),
    INDEX `project_team_member_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `projects` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `description` LONGTEXT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `start` DATE NULL,
    `end` DATE NULL,
    `clients` TEXT NULL,
    `other_stakeholders` TEXT NULL,
    `target` TEXT NULL,
    `milestones` TEXT NULL,
    `goals_contents` TEXT NULL,
    `benefits` TEXT NULL,
    `cost_efforts` TEXT NULL,
    `user_id_leader` BIGINT UNSIGNED NULL,
    `user_id_creator` BIGINT UNSIGNED NULL,
    `user_id_updated_by` BIGINT UNSIGNED NULL,
    `completion` DOUBLE NOT NULL DEFAULT 0,
    `risks` TEXT NULL,
    `is_archive` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `projects_custom_id_unique`(`custom_id`),
    INDEX `projects_user_id_creator_foreign`(`user_id_creator`),
    INDEX `projects_user_id_leader_foreign`(`user_id_leader`),
    INDEX `projects_user_id_updated_by_foreign`(`user_id_updated_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pt_norms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `specification` VARCHAR(255) NULL,
    `issue_revision_status` VARCHAR(255) NULL,
    `quality_class` VARCHAR(255) NULL,
    `test_scope` VARCHAR(255) NULL,
    `test_equipment` VARCHAR(255) NULL,
    `test_temperature` VARCHAR(255) NULL,
    `developer` VARCHAR(255) NULL,
    `penetrant` VARCHAR(255) NULL,
    `intermediate_cleaner` VARCHAR(255) NULL,
    `illuminance_lux` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `cleaner` VARCHAR(255) NULL,
    `registration_limit` VARCHAR(255) NULL,
    `control_unit` VARCHAR(255) NULL,
    `comments` VARCHAR(255) NULL,
    `lux_meter` VARCHAR(255) NULL,
    `batch_developer` VARCHAR(255) NULL,
    `batch_penetrant` VARCHAR(255) NULL,

    UNIQUE INDEX `pt_norms_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `quali_events` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `machine_id` BIGINT UNSIGNED NOT NULL,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `type` VARCHAR(255) NOT NULL,
    `registered_datetime` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `quali_events_machine_id_foreign`(`machine_id`),
    INDEX `quali_events_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `qualification_users` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `qualification_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `total_hours` DOUBLE NOT NULL DEFAULT 0,
    `is_suspended` BOOLEAN NOT NULL DEFAULT false,
    `is_prequalified` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `total_operations` DOUBLE NOT NULL,
    `note` VARCHAR(255) NULL,
    `hours_imported` DOUBLE NOT NULL DEFAULT 0,
    `operations_imported` DOUBLE NOT NULL DEFAULT 0,

    INDEX `qualification_users_user_id_foreign`(`user_id`),
    UNIQUE INDEX `qualification_users_qualification_id_user_id_unique`(`qualification_id`, `user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `qualifications` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_id` BIGINT UNSIGNED NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `operation_code` VARCHAR(255) NULL,
    `min_qualification_hours` DOUBLE NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `min_qualification_operations` DOUBLE NOT NULL DEFAULT 0,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,

    INDEX `qualifications_item_id_foreign`(`item_id`),
    INDEX `qualifications_machine_id_foreign`(`machine_id`),
    UNIQUE INDEX `qualifications_unique_index`(`item_id`, `machine_id`, `operation_code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `raw_dimension_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `offer_pos_raw_dimensions_id` BIGINT UNSIGNED NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    `encore_info` DOUBLE NULL,
    `lower_tolerance` DOUBLE NULL,
    `additional_dimensions` DOUBLE NULL,
    `sample_allowance` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `upper_tolerance` DOUBLE NULL,
    `warm` DOUBLE NULL,

    INDEX `raw_dimension_types_offer_pos_raw_dimensions_id_type_index`(`offer_pos_raw_dimensions_id`, `type`),
    UNIQUE INDEX `raw_dimension_types_offer_pos_raw_dimensions_id_type_unique`(`offer_pos_raw_dimensions_id`, `type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `releasable_users` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `releasable_type` VARCHAR(255) NOT NULL,
    `releasable_id` BIGINT UNSIGNED NOT NULL,
    `user_id_releaser` BIGINT UNSIGNED NULL,
    `status` VARCHAR(255) NOT NULL DEFAULT 'ASSIGNED',
    `released_date` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `releasable_users_releasable_type_releasable_id_index`(`releasable_type`, `releasable_id`),
    UNIQUE INDEX `unique_document_releaser`(`user_id_releaser`, `releasable_id`, `releasable_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `report_categories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `report_color_thresholds` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hall_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `green_from` DECIMAL(8, 2) NOT NULL,
    `green_to` DECIMAL(8, 2) NOT NULL,
    `yellow_from` DECIMAL(8, 2) NOT NULL,
    `yellow_to` DECIMAL(8, 2) NOT NULL,
    `red_from` DECIMAL(8, 2) NOT NULL,
    `red_to` DECIMAL(8, 2) NOT NULL,
    `hall_uid` VARCHAR(255) NULL,

    UNIQUE INDEX `report_color_thresholds_hall_uid_unique`(`hall_uid`),
    INDEX `report_color_thresholds_hall_id_foreign`(`hall_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `report_users` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `report_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `report_users_report_id_foreign`(`report_id`),
    INDEX `report_users_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reports` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `report_type` ENUM('OEE', 'USAGE', 'USAGE STATUS') NOT NULL DEFAULT 'OEE',
    `order` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `report_category_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `reports_report_category_id_foreign`(`report_category_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `residual_materials` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `specification` VARCHAR(255) NULL,
    `revision` VARCHAR(255) NULL,
    `free_text` VARCHAR(255) NULL,
    `marking` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `frequency` VARCHAR(255) NULL,
    `cross_section_type` VARCHAR(255) NULL,
    `offer_note` VARCHAR(255) NULL,
    `quantity_sample_geometries` INTEGER NULL,

    UNIQUE INDEX `residual_materials_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `resource_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `hall_id` BIGINT UNSIGNED NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `jpi_factor` DOUBLE NOT NULL DEFAULT 1,

    UNIQUE INDEX `resource_groups_custom_id_unique`(`custom_id`),
    INDEX `resource_groups_hall_id_foreign`(`hall_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `responsibles` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id_responsible` BIGINT UNSIGNED NOT NULL,
    `responsible_code` VARCHAR(255) NOT NULL,
    `responsible_color` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `responsibles_responsible_code_unique`(`responsible_code`),
    INDEX `responsibles_user_id_responsible_foreign`(`user_id_responsible`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `revenue_classifications` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sort_order` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `revenue_classifications_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `role_has_permissions` (
    `permission_id` BIGINT UNSIGNED NOT NULL,
    `role_id` BIGINT UNSIGNED NOT NULL,

    INDEX `role_has_permissions_role_id_foreign`(`role_id`),
    PRIMARY KEY (`permission_id`, `role_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `roles` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `guard_name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `roles_name_guard_name_unique`(`name`, `guard_name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sales_areas` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `is_active` BOOLEAN NULL DEFAULT true,
    `crm_id` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `sales_areas_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sales_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `is_active` BOOLEAN NULL DEFAULT true,
    `crm_id` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `sales_groups_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sales_opportunities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `customer_id` BIGINT UNSIGNED NOT NULL,
    `contact_person` VARCHAR(255) NULL,
    `request_date` DATE NULL,
    `offer_until_date` DATE NULL,
    `customer_reference` VARCHAR(255) NULL,
    `type` VARCHAR(255) NULL,
    `additional_info` VARCHAR(255) NULL,
    `changes` VARCHAR(255) NULL,
    `is_short_offer` BOOLEAN NOT NULL DEFAULT false,
    `is_specification_necessary` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `version` INTEGER NULL,
    `phase` VARCHAR(255) NULL,
    `status` VARCHAR(255) NULL,
    `crm_id` VARCHAR(255) NULL,
    `sales_group_id` BIGINT UNSIGNED NULL,
    `sales_area_id` BIGINT UNSIGNED NULL,
    `delivery_term_id` BIGINT UNSIGNED NULL,
    `country_id` BIGINT UNSIGNED NULL,
    `postal_code` VARCHAR(255) NULL,
    `destination` VARCHAR(255) NULL,

    INDEX `sales_opportunities_country_id_foreign`(`country_id`),
    INDEX `sales_opportunities_customer_id_foreign`(`customer_id`),
    INDEX `sales_opportunities_delivery_term_id_foreign`(`delivery_term_id`),
    INDEX `sales_opportunities_sales_area_id_foreign`(`sales_area_id`),
    INDEX `sales_opportunities_sales_group_id_foreign`(`sales_group_id`),
    UNIQUE INDEX `alternative_unique`(`custom_id`, `version`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sales_order_pos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `sales_order_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NOT NULL,
    `quantity` DOUBLE NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `customer_reference` VARCHAR(255) NULL,
    `customer_material_number` VARCHAR(255) NULL,
    `delivery_date` DATE NULL,
    `name` VARCHAR(255) NULL,
    `note_confirmation` TEXT NULL,
    `note_production` TEXT NULL,
    `note_labeling` TEXT NULL,
    `note_shipping` TEXT NULL,
    `note_sampling` TEXT NULL,
    `note_forging` TEXT NULL,
    `note_wbh` TEXT NULL,
    `note_bw` TEXT NULL,
    `note_qs` TEXT NULL,
    `note_manual_labeling` TEXT NULL,
    `note_labeling_1` TEXT NULL,
    `certificate_requirement` TEXT NULL,
    `label_type` TEXT NULL,
    `rust_protection_type` TEXT NULL,
    `item_name` TEXT NULL,

    INDEX `sales_order_pos_pos_sales_order_id_index`(`pos`, `sales_order_id`),
    INDEX `sales_order_pos_sales_order_id_foreign`(`sales_order_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sales_orders` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `customer_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `customer_reference` VARCHAR(255) NULL,

    UNIQUE INDEX `sales_orders_custom_id_unique`(`custom_id`),
    INDEX `sales_orders_customer_id_foreign`(`customer_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sales_status_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL,
    `custom_id` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sort_order` INTEGER NULL DEFAULT 0,

    UNIQUE INDEX `sales_status_groups_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sales_statuses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `show_in_kanban` BOOLEAN NOT NULL DEFAULT true,
    `sort_order` INTEGER NOT NULL DEFAULT 0,
    `color` VARCHAR(6) NOT NULL DEFAULT '000000',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `show_in_sales_funnel` BOOLEAN NOT NULL DEFAULT true,
    `sales_status_group_id` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `sales_statuses_custom_id_unique`(`custom_id`),
    INDEX `sales_statuses_sales_status_group_id_foreign`(`sales_status_group_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `section_activatables` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `activatable_type` VARCHAR(255) NOT NULL,
    `activatable_id` BIGINT UNSIGNED NOT NULL,
    `section` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `section_activatables_activatable_type_activatable_id_index`(`activatable_type`, `activatable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sectors` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `is_active` BOOLEAN NULL DEFAULT true,
    `crm_id` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `sectors_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sequence_operations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `specification_id` BIGINT UNSIGNED NOT NULL,
    `sequence_operation` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `sequence_operations_specification_id_sequence_operation_index`(`specification_id`, `sequence_operation`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `serial_number_profiles` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `check_stock` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `serial_number_profiles_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `email_username` VARCHAR(255) NULL,
    `email_address` VARCHAR(255) NULL,
    `email_password` VARCHAR(255) NULL,
    `email_port` INTEGER NOT NULL DEFAULT 80,
    `email_host` VARCHAR(255) NULL,
    `email_encryption` VARCHAR(255) NOT NULL DEFAULT 'SSL',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `client_name` VARCHAR(255) NULL,
    `status_board_sidebar_type` VARCHAR(255) NOT NULL DEFAULT 'STANDARD_1',
    `start_of_day` TIME(0) NULL,
    `date_to_consider` VARCHAR(255) NOT NULL DEFAULT 'SHIFT_START',
    `is_ewm_enabled` BOOLEAN NOT NULL DEFAULT false,
    `is_external_dms_enabled` BOOLEAN NOT NULL DEFAULT false,
    `is_packaging_instruction_necessary_for_hu` BOOLEAN NOT NULL DEFAULT false,
    `show_customer` BOOLEAN NOT NULL DEFAULT false,
    `show_filter_hall` BOOLEAN NULL DEFAULT true,
    `show_filter_machine_group` BOOLEAN NULL DEFAULT true,
    `show_filter_machine` BOOLEAN NULL DEFAULT true,
    `show_filter_item` BOOLEAN NULL DEFAULT true,
    `show_filter_prod_order` BOOLEAN NULL DEFAULT true,
    `show_op_prod_order` BOOLEAN NULL DEFAULT true,
    `show_op_item` BOOLEAN NULL DEFAULT true,
    `show_op_due_date` BOOLEAN NULL DEFAULT true,
    `show_op_release_date` BOOLEAN NULL DEFAULT true,
    `show_op_constraint_type` BOOLEAN NULL DEFAULT true,
    `show_op_alt_machine` BOOLEAN NULL DEFAULT true,
    `show_op_customer` BOOLEAN NULL DEFAULT true,
    `is_refresh_planvisu_enable` BOOLEAN NOT NULL DEFAULT false,
    `planvisu_refresh_interval` INTEGER NOT NULL DEFAULT 0,
    `show_filter_color_scheme` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shif_visu_overview_measure_type_submissions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `overview_details_id` BIGINT UNSIGNED NULL,
    `measure_type` VARCHAR(255) NULL,
    `creator` VARCHAR(255) NULL,
    `measure_component_id` INTEGER NULL,
    `component_name` VARCHAR(255) NULL,
    `component_type` VARCHAR(255) NULL,
    `is_corrective` BOOLEAN NOT NULL DEFAULT false,
    `view_in` VARCHAR(255) NULL,
    `option_id` INTEGER NULL,
    `option_value` VARCHAR(255) NULL,
    `model_type` VARCHAR(255) NULL,
    `details` LONGTEXT NULL,
    `title` VARCHAR(255) NULL,
    `responsible` VARCHAR(255) NULL,
    `start_date` DATETIME(0) NULL,
    `end_date` DATETIME(0) NULL,
    `restart_date` DATETIME(0) NULL,
    `is_finished` BOOLEAN NULL DEFAULT false,
    `status` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `fk_measure_overview_detail`(`overview_details_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shift_model_shifts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `shift_model_id` BIGINT UNSIGNED NOT NULL,
    `shift_id` BIGINT UNSIGNED NOT NULL,
    `day_of_week` INTEGER NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `shift_model_shifts_shift_id_foreign`(`shift_id`),
    INDEX `shift_model_shifts_shift_model_id_foreign`(`shift_model_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shift_models` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NULL,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `shift_models_custom_id_unique`(`custom_id`),
    UNIQUE INDEX `shift_models_name_unique`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shift_visu_component_options` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `shift_visu_component_id` BIGINT UNSIGNED NOT NULL,
    `option` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `unique_component_option`(`shift_visu_component_id`, `option`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shift_visu_components` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `is_required` BOOLEAN NOT NULL DEFAULT false,
    `model_type` VARCHAR(255) NULL,
    `component_type` VARCHAR(255) NULL,
    `view_in` VARCHAR(255) NULL,
    `measure_options` LONGTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `custom_id` VARCHAR(255) NOT NULL,

    UNIQUE INDEX `shift_visu_components_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shift_visu_hall_permissions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `hall_id` BIGINT UNSIGNED NOT NULL,
    `shift_visu_issue_type_id` BIGINT UNSIGNED NULL,
    `is_all` BOOLEAN NOT NULL DEFAULT true,
    `is_read` BOOLEAN NOT NULL DEFAULT false,
    `is_create` BOOLEAN NOT NULL DEFAULT false,
    `is_update` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `shift_visu_hall_permissions_hall_id_foreign`(`hall_id`),
    INDEX `shift_visu_hall_permissions_shift_visu_issue_type_id_foreign`(`shift_visu_issue_type_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shift_visu_issue_type_shift_visu_components` (
    `shift_visu_issue_type_id` BIGINT UNSIGNED NOT NULL,
    `shift_visu_component_id` BIGINT UNSIGNED NOT NULL,
    `is_mandatory` BOOLEAN NOT NULL DEFAULT false
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shift_visu_issue_type_shift_visu_measure_components` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `shift_visu_issue_type_id` BIGINT UNSIGNED NOT NULL,
    `measure_component_id` BIGINT UNSIGNED NULL,
    `option_name` VARCHAR(255) NULL,
    `option_id` INTEGER NULL,
    `component_type` VARCHAR(255) NULL,
    `is_corrective` BOOLEAN NOT NULL DEFAULT false,
    `is_mandatory` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `fk_measure_component`(`measure_component_id`),
    INDEX `svit_svmc_fk`(`shift_visu_issue_type_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shift_visu_issue_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL,
    `custom_id` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `is_corrective` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `shift_visu_issue_types_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shift_visu_overview_component_options` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `overview_details_id` BIGINT UNSIGNED NULL,
    `component_id` INTEGER NOT NULL,
    `view_in` VARCHAR(255) NULL,
    `component_type` VARCHAR(255) NULL,
    `option_id` INTEGER NULL,
    `option_value` TEXT NULL,
    `model_type` VARCHAR(255) NULL,
    `option_value_is_checked` BOOLEAN NOT NULL DEFAULT false,
    `option_value_date` DATETIME(0) NULL,
    `option_value_text` LONGTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `fk_overview_detail_id`(`overview_details_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shift_visu_overview_details` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_urgent` BOOLEAN NOT NULL DEFAULT false,
    `is_finished` BOOLEAN NOT NULL DEFAULT false,
    `hall_id` BIGINT UNSIGNED NOT NULL,
    `creator_id` BIGINT UNSIGNED NOT NULL,
    `responsible_id` BIGINT UNSIGNED NULL,
    `error_id` BIGINT UNSIGNED NOT NULL,
    `error_type` VARCHAR(255) NULL,
    `title` VARCHAR(255) NULL,
    `description` LONGTEXT NULL,
    `chat_id` BIGINT UNSIGNED NULL,
    `end_date` DATE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `shift_visu_overview_details_chat_id_foreign`(`chat_id`),
    INDEX `shift_visu_overview_details_creator_id_foreign`(`creator_id`),
    INDEX `shift_visu_overview_details_error_id_foreign`(`error_id`),
    INDEX `shift_visu_overview_details_hall_id_foreign`(`hall_id`),
    INDEX `shift_visu_overview_details_responsible_id_foreign`(`responsible_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shifts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `start_time` TIME(0) NOT NULL,
    `end_time` TIME(0) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `break_minutes` INTEGER NOT NULL,
    `date_to_consider` VARCHAR(255) NOT NULL DEFAULT 'SHIFT_START',
    `is_active` BOOLEAN NOT NULL DEFAULT true,

    UNIQUE INDEX `shifts_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sim_call_offs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `call_off_simulation_id` BIGINT UNSIGNED NOT NULL,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `date_monday` DATE NOT NULL,
    `year` INTEGER UNSIGNED NOT NULL,
    `week` INTEGER UNSIGNED NOT NULL,
    `quantity` DOUBLE NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `sim_call_offs_date_monday_index`(`date_monday`),
    INDEX `sim_call_offs_item_id_foreign`(`item_id`),
    UNIQUE INDEX `sim_call_offs_call_off_simulation_id_item_id_year_week_unique`(`call_off_simulation_id`, `item_id`, `year`, `week`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `specification_chem_analyses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `specification_id` BIGINT UNSIGNED NOT NULL,
    `chem_analysis_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `specification_chem_analyses_chem_analysis_id_foreign`(`chem_analysis_id`),
    INDEX `specification_chem_analyses_specification_id_foreign`(`specification_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `specifications` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `name` VARCHAR(255) NULL,
    `documentation_id` BIGINT UNSIGNED NULL,
    `metallography_id` BIGINT UNSIGNED NULL,
    `testing_scope_id` BIGINT UNSIGNED NULL,
    `non_destructive_testing_id` BIGINT UNSIGNED NULL,
    `residual_material_id` BIGINT UNSIGNED NULL,
    `material_id` BIGINT UNSIGNED NULL,
    `hardenability_range_id` BIGINT UNSIGNED NULL,
    `deformation_id` BIGINT UNSIGNED NULL,
    `material_analysis_id` BIGINT UNSIGNED NULL,
    `hwe_work_plan_id` BIGINT UNSIGNED NULL,
    `note` TEXT NULL,

    UNIQUE INDEX `specifications_custom_id_unique`(`custom_id`),
    INDEX `specifications_deformation_id_foreign`(`deformation_id`),
    INDEX `specifications_documentation_id_foreign`(`documentation_id`),
    INDEX `specifications_hardenability_range_id_foreign`(`hardenability_range_id`),
    INDEX `specifications_hwe_work_plan_id_foreign`(`hwe_work_plan_id`),
    INDEX `specifications_material_analysis_id_foreign`(`material_analysis_id`),
    INDEX `specifications_material_id_foreign`(`material_id`),
    INDEX `specifications_metallography_id_foreign`(`metallography_id`),
    INDEX `specifications_non_destructive_testing_id_foreign`(`non_destructive_testing_id`),
    INDEX `specifications_residual_material_id_foreign`(`residual_material_id`),
    INDEX `specifications_testing_scope_id_foreign`(`testing_scope_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `standard_value_key_activity_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `standard_value_key_id` BIGINT UNSIGNED NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `pos` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_clockin_enabled` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `standard_value_key_unique`(`standard_value_key_id`, `pos`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `standard_value_keys` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `standard_value_keys_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `stock_operation_inputs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `stock_operation_id` BIGINT UNSIGNED NOT NULL,
    `quantity` DOUBLE NOT NULL,
    `item_state_id` BIGINT UNSIGNED NOT NULL,
    `batch` VARCHAR(255) NULL,
    `serial` VARCHAR(255) NULL,
    `stockable_type` VARCHAR(255) NOT NULL,
    `stockable_id` BIGINT UNSIGNED NOT NULL,
    `positionable_type` VARCHAR(255) NULL,
    `positionable_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `stock_operation_inputs_item_state_id_foreign`(`item_state_id`),
    INDEX `stock_operation_inputs_positionable_type_positionable_id_index`(`positionable_type`, `positionable_id`),
    INDEX `stock_operation_inputs_stock_operation_id_foreign`(`stock_operation_id`),
    INDEX `stock_operation_inputs_stockable_type_stockable_id_index`(`stockable_type`, `stockable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `stock_operation_outputs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `stock_operation_id` BIGINT UNSIGNED NOT NULL,
    `quantity` DOUBLE NOT NULL,
    `item_state_id` BIGINT UNSIGNED NOT NULL,
    `batch` VARCHAR(255) NULL,
    `serial` VARCHAR(255) NULL,
    `stockable_type` VARCHAR(255) NOT NULL,
    `stockable_id` BIGINT UNSIGNED NOT NULL,
    `positionable_type` VARCHAR(255) NOT NULL,
    `positionable_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `stock_operation_outputs_item_state_id_foreign`(`item_state_id`),
    INDEX `stock_operation_outputs_positionable_type_positionable_id_index`(`positionable_type`, `positionable_id`),
    INDEX `stock_operation_outputs_stock_operation_id_foreign`(`stock_operation_id`),
    INDEX `stock_operation_outputs_stockable_type_stockable_id_index`(`stockable_type`, `stockable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `stock_operations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `performed_datetime` DATETIME(0) NOT NULL,
    `type` VARCHAR(255) NOT NULL DEFAULT 'GOODS_RECEIPT',
    `context_type` VARCHAR(255) NULL,
    `context_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `stock_operations_custom_id_unique`(`custom_id`),
    INDEX `stock_operations_context_type_context_id_index`(`context_type`, `context_id`),
    INDEX `stock_operations_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `stocks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `quantity` DOUBLE NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `batch` VARCHAR(255) NULL,
    `serial` VARCHAR(255) NULL,
    `stockable_type` VARCHAR(255) NOT NULL,
    `stockable_id` BIGINT UNSIGNED NOT NULL,
    `item_state_id` BIGINT UNSIGNED NOT NULL,
    `positionable_type` VARCHAR(255) NULL,
    `positionable_id` BIGINT UNSIGNED NULL,

    INDEX `stocks_item_state_id_foreign`(`item_state_id`),
    INDEX `stocks_positionable_type_positionable_id_index`(`positionable_type`, `positionable_id`),
    INDEX `stocks_stockable_type_stockable_id_index`(`stockable_type`, `stockable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `storage_bins` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `storage_type_id` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `storage_bins_custom_id_unique`(`custom_id`),
    INDEX `storage_bins_storage_type_id_foreign`(`storage_type_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `storage_locations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `name` VARCHAR(255) NULL,
    `warehouse_id` BIGINT UNSIGNED NULL,
    `plant_id` BIGINT UNSIGNED NULL,
    `transport_order_type_id` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `storage_locations_custom_id_unique`(`custom_id`),
    INDEX `storage_locations_plant_id_foreign`(`plant_id`),
    INDEX `storage_locations_transport_order_type_id_foreign`(`transport_order_type_id`),
    INDEX `storage_locations_warehouse_id_foreign`(`warehouse_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `storage_sections` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `storage_sections_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `storage_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `storage_types_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sub_responsible_task` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `task_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `sub_responsible_task_task_id_foreign`(`task_id`),
    INDEX `sub_responsible_task_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `supplier_tasks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `supplier_id` BIGINT UNSIGNED NOT NULL,
    `task_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `supplier_tasks_supplier_id_foreign`(`supplier_id`),
    INDEX `supplier_tasks_task_id_foreign`(`task_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `suppliers` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_active` TINYINT NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `email` VARCHAR(255) NULL,
    `telephone` VARCHAR(255) NULL,
    `address` VARCHAR(255) NULL,
    `province` VARCHAR(255) NULL,

    UNIQUE INDEX `suppliers_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `task_priorities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `color` VARCHAR(6) NOT NULL DEFAULT '000000',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `task_priorities_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `task_visu_reports` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `reportable_type` VARCHAR(255) NOT NULL,
    `reportable_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `report_type` VARCHAR(255) NOT NULL DEFAULT 'WEEKLY',
    `description` LONGTEXT NULL,
    `start` DATE NOT NULL,
    `end` DATE NOT NULL,
    `is_show_value` BOOLEAN NOT NULL DEFAULT true,
    `is_show_target` BOOLEAN NOT NULL DEFAULT true,
    `values` LONGTEXT NULL,
    `targets` LONGTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `task_visu_reports_reportable_type_reportable_id_index`(`reportable_type`, `reportable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tasks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `description` LONGTEXT NULL,
    `user_id_creator` BIGINT UNSIGNED NULL,
    `user_id_responsible` BIGINT UNSIGNED NULL,
    `team_id` BIGINT UNSIGNED NULL,
    `meeting_id` BIGINT UNSIGNED NULL,
    `project_id` BIGINT UNSIGNED NULL,
    `start` DATE NULL,
    `end` DATE NULL,
    `completion` DOUBLE NOT NULL DEFAULT 0,
    `chat_id` BIGINT UNSIGNED NOT NULL,
    `task_priority_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sectionable_type` VARCHAR(255) NULL,
    `sectionable_id` BIGINT UNSIGNED NULL,
    `visu` VARCHAR(255) NOT NULL DEFAULT 'TASKVISU',
    `on_hold` BOOLEAN NOT NULL DEFAULT false,
    `action_setting_id` BIGINT UNSIGNED NULL,
    `user_id_updated_by` BIGINT UNSIGNED NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,

    UNIQUE INDEX `tasks_custom_id_unique`(`custom_id`),
    INDEX `tasks_action_setting_id_foreign`(`action_setting_id`),
    INDEX `tasks_chat_id_foreign`(`chat_id`),
    INDEX `tasks_meeting_id_foreign`(`meeting_id`),
    INDEX `tasks_project_id_foreign`(`project_id`),
    INDEX `tasks_sectionable_type_sectionable_id_index`(`sectionable_type`, `sectionable_id`),
    INDEX `tasks_task_priority_id_foreign`(`task_priority_id`),
    INDEX `tasks_team_id_foreign`(`team_id`),
    INDEX `tasks_user_id_creator_foreign`(`user_id_creator`),
    INDEX `tasks_user_id_responsible_foreign`(`user_id_responsible`),
    INDEX `tasks_user_id_updated_by_foreign`(`user_id_updated_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `team_user` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `team_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `team_user_user_id_foreign`(`user_id`),
    UNIQUE INDEX `team_user_team_id_user_id_unique`(`team_id`, `user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `teams` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `description` LONGTEXT NULL,
    `chat_id` BIGINT UNSIGNED NULL,
    `user_id_creator` BIGINT UNSIGNED NULL,
    `user_id_updated_by` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `teams_custom_id_unique`(`custom_id`),
    INDEX `teams_chat_id_foreign`(`chat_id`),
    INDEX `teams_user_id_creator_foreign`(`user_id_creator`),
    INDEX `teams_user_id_updated_by_foreign`(`user_id_updated_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `terminals` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `hall_id` BIGINT UNSIGNED NULL,
    `printer_id` BIGINT UNSIGNED NULL,
    `ip_address` VARCHAR(45) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `terminals_hall_id_foreign`(`hall_id`),
    INDEX `terminals_printer_id_foreign`(`printer_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `testing_scope_according_to_impact_tests` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `testing_scope_id` BIGINT UNSIGNED NOT NULL,
    `according_to_impact_test` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `testing_scope_id_according_to_impact_test_index`(`testing_scope_id`, `according_to_impact_test`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `testing_scope_according_to_tensile_tests` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `testing_scope_id` BIGINT UNSIGNED NOT NULL,
    `according_to_tensile_test` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `testing_scope_id_according_to_tensile_test_index`(`testing_scope_id`, `according_to_tensile_test`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `testing_scope_attestation_entities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `testing_scope_id` BIGINT UNSIGNED NOT NULL,
    `attestation_entity` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `testing_scope_id_attestation_entity_index`(`testing_scope_id`, `attestation_entity`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `testing_scope_classified_bies` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `testing_scope_id` BIGINT UNSIGNED NOT NULL,
    `classified_by` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `testing_scope_classified_bies_id_unique`(`testing_scope_id`, `classified_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `testing_scope_melting_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `testing_scope_id` BIGINT UNSIGNED NOT NULL,
    `melting_type` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `testing_scope_melting_types_id_unique`(`testing_scope_id`, `melting_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `testing_scope_sample_depths` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `testing_scope_id` BIGINT UNSIGNED NOT NULL,
    `sample_depth` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `testing_scope_sample_depths_testing_scope_id_sample_depth_unique`(`testing_scope_id`, `sample_depth`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `testing_scopes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `issue_revision` VARCHAR(255) NOT NULL,
    `attestation` VARCHAR(255) NOT NULL,
    `frequency` VARCHAR(255) NOT NULL,
    `frequency_at_3_2` VARCHAR(255) NULL,
    `specimen_material` VARCHAR(255) NULL,
    `specimen_allowance` VARCHAR(255) NULL,
    `specimen_dimension` VARCHAR(255) NOT NULL,
    `bhp_dimension` VARCHAR(255) NULL,
    `specimen_rest_material` BOOLEAN NOT NULL DEFAULT false,
    `specimen_location` VARCHAR(255) NULL,
    `zug` DOUBLE NULL,
    `kbz` DOUBLE NULL,
    `tensile_test_external_testing` BOOLEAN NOT NULL DEFAULT false,
    `reh` DOUBLE NULL,
    `reh_min` DOUBLE NULL,
    `rp_1_0` DOUBLE NULL,
    `rm` DOUBLE NULL,
    `rm_min` DOUBLE NULL,
    `a5_min` DOUBLE NULL,
    `a4_min` DOUBLE NULL,
    `z_min` DOUBLE NULL,
    `rp_rm_ratio` DOUBLE NULL,
    `impact_test_external_testing` BOOLEAN NOT NULL DEFAULT false,
    `impact_test_typ` VARCHAR(255) NULL,
    `impact_test_temperature` DOUBLE NULL,
    `impact_test_details` VARCHAR(255) NULL,
    `tensile_test_details` VARCHAR(255) NULL,
    `tensile_test_warm_according_to` VARCHAR(255) NULL,
    `tensile_test_warm_external_testing` BOOLEAN NOT NULL DEFAULT false,
    `tensile_test_warm_details` VARCHAR(255) NULL,
    `hardness_test_location` VARCHAR(255) NULL,
    `max_hbw_on_the_component` DOUBLE NULL,
    `min_hbw_on_the_component` DOUBLE NULL,
    `max_hbw_on_sample` DOUBLE NULL,
    `min_hbw_on_sample` DOUBLE NULL,
    `hardness_test_details` VARCHAR(255) NULL,
    `hardness_test_type` VARCHAR(255) NULL,
    `hardness_details` VARCHAR(255) NULL,
    `jominy_test` BOOLEAN NOT NULL DEFAULT false,
    `jominy_details` VARCHAR(255) NULL,
    `further_testing` VARCHAR(255) NULL,
    `further_testing_external` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `kbz_0` DOUBLE NULL,
    `kbz_m_20` DOUBLE NULL,
    `kbz_m_50` DOUBLE NULL,
    `kbz_m_60` DOUBLE NULL,
    `zug_gt_40` DOUBLE NULL,
    `zug_300` DOUBLE NULL,
    `test_fold_and_bending` BOOLEAN NOT NULL DEFAULT false,
    `test_blue_structure` BOOLEAN NOT NULL DEFAULT false,
    `test_baumann_imprint` BOOLEAN NOT NULL DEFAULT false,
    `test_pin` BOOLEAN NOT NULL DEFAULT false,
    `test_us_calibration` BOOLEAN NOT NULL DEFAULT false,
    `toughness` DOUBLE NULL,
    `lateral_expansion` DOUBLE NULL,
    `quantity_testing_pieces` INTEGER NULL,
    `offer_note` VARCHAR(255) NULL,
    `mq_quality` VARCHAR(255) NULL,
    `me_quality` VARCHAR(255) NULL,
    `is_classified_steel_plant` BOOLEAN NOT NULL DEFAULT false,
    `is_eu_material` BOOLEAN NOT NULL DEFAULT false,
    `attestation_following_regulation` BOOLEAN NOT NULL DEFAULT false,
    `temperature_wzv` INTEGER NULL,
    `impact_energy_av` DOUBLE NULL,
    `setpoint_hot_tensile_test` DOUBLE NULL,
    `max_sample_depth` VARCHAR(255) NULL,
    `buffer_90_mm` BOOLEAN NOT NULL DEFAULT false,
    `lotweight` INTEGER NULL,
    `max_lotsize` INTEGER NULL,
    `max_ht_weight_lot_testing` INTEGER NULL,
    `bhp_info` VARCHAR(255) NULL,

    UNIQUE INDEX `testing_scopes_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tool_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `hall_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `tool_groups_custom_id_unique`(`custom_id`),
    INDEX `tool_groups_hall_id_foreign`(`hall_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tool_status_histories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `prod_order_id` BIGINT UNSIGNED NULL,
    `prod_status` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `tool_status_histories_prod_order_id_foreign`(`prod_order_id`),
    UNIQUE INDEX `tool_status_per_day_unique`(`item_id`, `prod_order_id`, `created_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tool_status_histories_backup` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `prod_order_id` BIGINT UNSIGNED NULL,
    `prod_status` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `tool_status_histories_backup_item_id_foreign`(`item_id`),
    INDEX `tool_status_histories_backup_prod_order_id_foreign`(`prod_order_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tool_tasks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tool_id` BIGINT UNSIGNED NOT NULL,
    `task_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `tool_tasks_task_id_foreign`(`task_id`),
    INDEX `tool_tasks_tool_id_foreign`(`tool_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tool_tool_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tool_id` BIGINT UNSIGNED NOT NULL,
    `tool_group_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `tool_tool_groups_tool_group_id_foreign`(`tool_group_id`),
    UNIQUE INDEX `tool_tool_groups_tool_id_tool_group_id_unique`(`tool_id`, `tool_group_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tools` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `construction_year` YEAR NULL,
    `cavity` INTEGER NULL DEFAULT 1,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `guaranteed_quantity` INTEGER NULL,
    `storage_shelf` VARCHAR(255) NULL,
    `storage_level` VARCHAR(255) NULL,
    `storage_compartment` VARCHAR(255) NULL,
    `storage_location` VARCHAR(255) NULL,

    UNIQUE INDEX `tools_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tpm_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `plant_id` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `tpm_groups_custom_id_unique`(`custom_id`),
    INDEX `tpm_groups_plant_id_foreign`(`plant_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tpm_sub_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `tpm_group_id` BIGINT UNSIGNED NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `tpm_sub_groups_custom_id_unique`(`custom_id`),
    INDEX `tpm_sub_groups_tpm_group_id_foreign`(`tpm_group_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `training_trainees` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `training_id` BIGINT UNSIGNED NOT NULL,
    `user_id_trainee` BIGINT UNSIGNED NOT NULL,
    `mail` BOOLEAN NOT NULL DEFAULT false,
    `status` VARCHAR(255) NOT NULL DEFAULT 'CREATED',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `due_date` TIMESTAMP(0) NULL,
    `completed_date` TIMESTAMP(0) NULL,
    `trainer_status` VARCHAR(255) NOT NULL DEFAULT 'ASSIGNED',
    `is_effective` BOOLEAN NOT NULL DEFAULT false,

    INDEX `training_trainees_training_id_foreign`(`training_id`),
    UNIQUE INDEX `unique_trainee_training`(`user_id_trainee`, `training_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `training_user_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `training_id` BIGINT UNSIGNED NOT NULL,
    `user_group_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `training_user_groups_training_id_foreign`(`training_id`),
    INDEX `training_user_groups_user_group_id_foreign`(`user_group_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `training_workspaces` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `training_id` BIGINT UNSIGNED NOT NULL,
    `workspace_type` VARCHAR(255) NOT NULL,
    `workspace_id` BIGINT UNSIGNED NOT NULL,
    `status` VARCHAR(255) NOT NULL DEFAULT 'CREATED',
    `interval_amount` INTEGER NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `due_date` TIMESTAMP(0) NULL,
    `interval_type` VARCHAR(255) NOT NULL DEFAULT 'SECONDS',

    INDEX `training_workspaces_workspace_type_workspace_id_index`(`workspace_type`, `workspace_id`),
    UNIQUE INDEX `unique_workspace_training`(`training_id`, `workspace_id`, `workspace_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `trainings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `trainable_type` VARCHAR(255) NOT NULL,
    `trainable_id` BIGINT UNSIGNED NOT NULL,
    `user_id_trainer` BIGINT UNSIGNED NULL,
    `status` VARCHAR(255) NOT NULL DEFAULT 'CREATED',
    `type` VARCHAR(255) NOT NULL DEFAULT 'STANDARD',
    `due_date_time` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `trainings_trainable_type_trainable_id_index`(`trainable_type`, `trainable_id`),
    UNIQUE INDEX `unique_training`(`user_id_trainer`, `trainable_id`, `trainable_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transport_order_pos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `pos` VARCHAR(255) NOT NULL,
    `prod_order_pos_bom_pos_id` BIGINT UNSIGNED NULL,
    `transport_order_id` BIGINT UNSIGNED NOT NULL,
    `responsible_user_id` BIGINT UNSIGNED NOT NULL,
    `status` VARCHAR(255) NOT NULL DEFAULT 'NOT_ACCEPTED',
    `is_accepted` BOOLEAN NOT NULL DEFAULT false,
    `is_urgent` BOOLEAN NOT NULL DEFAULT false,
    `entry_date` DATETIME(0) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `transport_order_type_id` BIGINT UNSIGNED NULL,
    `transportable_type` VARCHAR(255) NULL,
    `transportable_id` BIGINT UNSIGNED NULL,
    `is_completed` BOOLEAN NOT NULL DEFAULT false,
    `quantity` DOUBLE NOT NULL DEFAULT 0,
    `source_type` VARCHAR(255) NULL,
    `source_id` BIGINT UNSIGNED NULL,
    `destination_type` VARCHAR(255) NULL,
    `destination_id` BIGINT UNSIGNED NULL,
    `item_state_id` BIGINT UNSIGNED NULL,
    `is_cancelled` BOOLEAN NOT NULL DEFAULT false,
    `user_id_cancelled_by` BIGINT UNSIGNED NULL,

    INDEX `transport_order_pos_destination_type_destination_id_index`(`destination_type`, `destination_id`),
    INDEX `transport_order_pos_item_state_id_foreign`(`item_state_id`),
    INDEX `transport_order_pos_prod_order_pos_bom_pos_id_foreign`(`prod_order_pos_bom_pos_id`),
    INDEX `transport_order_pos_responsible_user_id_foreign`(`responsible_user_id`),
    INDEX `transport_order_pos_source_type_source_id_index`(`source_type`, `source_id`),
    INDEX `transport_order_pos_transport_order_type_id_foreign`(`transport_order_type_id`),
    INDEX `transport_order_pos_transportable_type_transportable_id_index`(`transportable_type`, `transportable_id`),
    INDEX `transport_order_pos_user_id_cancelled_by_foreign`(`user_id_cancelled_by`),
    UNIQUE INDEX `transport_order_pos_transport_order_id_pos_unique`(`transport_order_id`, `pos`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transport_order_pos_deliveries` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `transport_order_pos_id` BIGINT UNSIGNED NULL,
    `delivered_quantity` DOUBLE NOT NULL DEFAULT 0,
    `is_completed` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `transportable_type` VARCHAR(255) NULL,
    `transportable_id` BIGINT UNSIGNED NULL,
    `serial` VARCHAR(255) NULL,
    `batch` VARCHAR(255) NULL,

    INDEX `transport_OPD_transportable_type_transportable_id_index`(`transportable_type`, `transportable_id`),
    INDEX `transport_order_pos_deliveries_transport_order_pos_id_foreign`(`transport_order_pos_id`),
    INDEX `transport_order_pos_deliveries_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transport_order_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `transport_order_types_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transport_orders` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `delivery_date` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `transport_orders_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `unit_of_measures` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `unit_of_measures_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `us_norm_adjustments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `us_norm_id` BIGINT UNSIGNED NOT NULL,
    `adjustment` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `us_norm_adjustments_us_norm_id_adjustment_index`(`us_norm_id`, `adjustment`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `us_norm_rating_justifications` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `us_norm_rating_id` BIGINT UNSIGNED NOT NULL,
    `justification` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `us_norm_rating_justification_idx`(`us_norm_rating_id`, `justification`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `us_norm_ratings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `us_norm_id` BIGINT UNSIGNED NOT NULL,
    `rating` VARCHAR(255) NULL,
    `probe` VARCHAR(255) NULL,
    `test_direction` VARCHAR(255) NULL,
    `sender_section` DOUBLE NULL,
    `amplification` DOUBLE NULL,
    `ksr` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `us_norm_ratings_us_norm_id_foreign`(`us_norm_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `us_norm_test_scopes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `us_norm_id` BIGINT UNSIGNED NOT NULL,
    `test_scope` VARCHAR(255) NULL,
    `probe` VARCHAR(255) NULL,
    `test_direction` VARCHAR(255) NULL,
    `sound_attenuation` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sound_attenuation_operator` VARCHAR(255) NULL,

    INDEX `us_norm_test_scopes_us_norm_id_foreign`(`us_norm_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `us_norm_test_sections` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `us_norm_id` BIGINT UNSIGNED NOT NULL,
    `test_section` VARCHAR(255) NULL,
    `registration_threshold` DOUBLE NULL,
    `reporting_threshold` DOUBLE NULL,
    `decision_threshold` DOUBLE NULL,
    `allowed_threshold` DOUBLE NULL,
    `expansion_with` DOUBLE NULL,
    `expansion_without` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `registration_threshold_operator` VARCHAR(255) NULL,
    `reporting_threshold_operator` VARCHAR(255) NULL,
    `decision_threshold_operator` VARCHAR(255) NULL,
    `allowed_threshold_operator` VARCHAR(255) NULL,
    `expansion_with_operator` VARCHAR(255) NULL,
    `expansion_without_operator` VARCHAR(255) NULL,
    `scrap_limit` DOUBLE NULL,
    `scrap_limit_operator` VARCHAR(255) NULL,

    INDEX `us_norm_test_sections_us_norm_id_foreign`(`us_norm_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `us_norms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `specification` VARCHAR(255) NULL,
    `issue` VARCHAR(255) NULL,
    `quality_class` VARCHAR(255) NULL,
    `surface_finish` VARCHAR(255) NULL,
    `coupling` VARCHAR(255) NOT NULL DEFAULT 'PASTE',
    `amplification` VARCHAR(255) NOT NULL DEFAULT 'AVG',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `name` VARCHAR(255) NULL,
    `detection_threshold` DOUBLE NULL,
    `residual_magnetism` DOUBLE NULL,
    `residual_magnetism_unit` VARCHAR(255) NULL,
    `detection_threshold_operator` VARCHAR(255) NULL,
    `note` VARCHAR(255) NULL,
    `testing_device` VARCHAR(255) NULL,
    `shim` VARCHAR(255) NULL,

    UNIQUE INDEX `us_norms_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `hall_id` BIGINT UNSIGNED NULL,
    `is_enabled_for_clockin` BOOLEAN NOT NULL DEFAULT true,

    UNIQUE INDEX `user_groups_custom_id_unique`(`custom_id`),
    INDEX `user_groups_hall_id_foreign`(`hall_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_position_times` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `pos` VARCHAR(255) NULL,
    `start` DATE NOT NULL,
    `end` DATE NULL,
    `name` VARCHAR(255) NULL,
    `shift_model_id` BIGINT UNSIGNED NULL,
    `plant_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `user_position_times_plant_id_foreign`(`plant_id`),
    INDEX `user_position_times_shift_model_id_foreign`(`shift_model_id`),
    INDEX `user_position_times_user_id_foreign`(`user_id`),
    UNIQUE INDEX `user_position_times_user_id_pos_unique`(`user_id`, `pos`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_registered_times` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `prod_order_pos_operation_id` BIGINT UNSIGNED NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `machine_id` BIGINT UNSIGNED NULL,
    `hours_split` DOUBLE NOT NULL,
    `machine_state_id` BIGINT UNSIGNED NULL,
    `shift_id` BIGINT UNSIGNED NULL,
    `date` DATE NOT NULL,
    `status_operation` VARCHAR(255) NULL,
    `start` DATETIME(0) NULL,
    `end` DATETIME(0) NULL,
    `standard_value_key_activity_type_id` BIGINT UNSIGNED NULL,
    `is_generated` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_exported` BOOLEAN NOT NULL DEFAULT false,

    INDEX `user_registered_times_machine_id_foreign`(`machine_id`),
    INDEX `user_registered_times_machine_state_id_foreign`(`machine_state_id`),
    INDEX `user_registered_times_prod_order_pos_operation_id_foreign`(`prod_order_pos_operation_id`),
    INDEX `user_registered_times_shift_id_foreign`(`shift_id`),
    INDEX `user_registered_times_svk_activity_type_id_foreign`(`standard_value_key_activity_type_id`),
    INDEX `user_registered_times_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_user_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `user_group_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `user_user_groups_user_group_id_foreign`(`user_group_id`),
    INDEX `user_user_groups_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NULL,
    `email_verified_at` TIMESTAMP(0) NULL,
    `password` VARCHAR(255) NULL,
    `remember_token` VARCHAR(100) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `custom_id` VARCHAR(255) NOT NULL,
    `chip_number` VARCHAR(255) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `username` VARCHAR(255) NULL,
    `is_melter` BOOLEAN NOT NULL DEFAULT false,
    `is_mp_offer_user` BOOLEAN NOT NULL DEFAULT false,
    `is_mp_offer_admin` BOOLEAN NOT NULL DEFAULT false,
    `mp_is_allowed_reoffer` BOOLEAN NULL DEFAULT false,
    `supervisor1_user_id` BIGINT UNSIGNED NULL,
    `supervisor2_user_id` BIGINT UNSIGNED NULL,
    `is_supervisor` BOOLEAN NOT NULL DEFAULT false,
    `is_absence_manager_admin` BOOLEAN NOT NULL DEFAULT false,
    `ip_address` VARCHAR(45) NULL,
    `is_imported_from_erp` BOOLEAN NOT NULL DEFAULT false,
    `user_short_code` VARCHAR(255) NULL,
    `hwe_examiner_qualification` VARCHAR(255) NULL,
    `shift_model_id` BIGINT UNSIGNED NULL,
    `user_type` VARCHAR(255) NULL,
    `note` VARCHAR(255) NULL,
    `gender` VARCHAR(255) NULL,
    `birthday` DATE NULL,
    `short_code` VARCHAR(255) NULL,
    `hall_id` BIGINT UNSIGNED NULL,
    `is_operator` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `users_email_unique`(`email`),
    UNIQUE INDEX `users_custom_id_unique`(`custom_id`),
    UNIQUE INDEX `users_username_unique`(`username`),
    INDEX `fk_supervisor1`(`supervisor1_user_id`),
    INDEX `fk_supervisor2`(`supervisor2_user_id`),
    INDEX `users_hall_id_foreign`(`hall_id`),
    INDEX `users_shift_model_id_foreign`(`shift_model_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `visibility_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(255) NOT NULL,
    `metadata` LONGTEXT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `visibility_settings_type_unique`(`type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vt_norm_auxiliary_means` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `vt_norm_id` BIGINT UNSIGNED NOT NULL,
    `auxiliary_mean` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `vt_norm_auxiliary_means_vt_norm_id_auxiliary_mean_index`(`vt_norm_id`, `auxiliary_mean`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vt_norm_test_techniques` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `vt_norm_id` BIGINT UNSIGNED NOT NULL,
    `test_technique` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `vt_norm_test_techniques_vt_norm_id_test_technique_index`(`vt_norm_id`, `test_technique`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vt_norms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `specification` VARCHAR(255) NULL,
    `revision` VARCHAR(255) NULL,
    `quality_class` VARCHAR(255) NULL,
    `test_scope` VARCHAR(255) NULL,
    `Illuminance` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `registration_limit` VARCHAR(255) NULL,
    `surface_quality` VARCHAR(255) NULL,
    `lux_meter` VARCHAR(255) NULL,
    `comments` VARCHAR(255) NULL,

    UNIQUE INDEX `vt_norms_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `warehouses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `warehouses_custom_id_unique`(`custom_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `workload_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `daily_working_hours` DOUBLE NOT NULL DEFAULT 8,
    `weekly_working_days` DOUBLE NOT NULL DEFAULT 5,
    `hall_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `workload_settings_hall_id_foreign`(`hall_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `absence_requests` ADD CONSTRAINT `absence_requests_absence_type_id_foreign` FOREIGN KEY (`absence_type_id`) REFERENCES `absence_types`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `absence_requests` ADD CONSTRAINT `absence_requests_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `absence_requests` ADD CONSTRAINT `absence_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `action_meetings` ADD CONSTRAINT `action_meetings_action_setting_id_foreign` FOREIGN KEY (`action_setting_id`) REFERENCES `action_settings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `action_meetings` ADD CONSTRAINT `action_meetings_meeting_id_foreign` FOREIGN KEY (`meeting_id`) REFERENCES `meetings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `area_user` ADD CONSTRAINT `area_user_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `areas`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `area_user` ADD CONSTRAINT `area_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `attribute_set_options` ADD CONSTRAINT `attribute_set_options_attribute_set_id_foreign` FOREIGN KEY (`attribute_set_id`) REFERENCES `attribute_sets`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `attribute_sets` ADD CONSTRAINT `attribute_sets_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plants`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `backlog_item_weeks` ADD CONSTRAINT `backlog_item_weeks_backlog_item_id_foreign` FOREIGN KEY (`backlog_item_id`) REFERENCES `backlog_items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `backlog_items` ADD CONSTRAINT `backlog_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `bom_pos` ADD CONSTRAINT `bom_pos_bom_id_foreign` FOREIGN KEY (`bom_id`) REFERENCES `boms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `bom_pos` ADD CONSTRAINT `bom_pos_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `bom_pos` ADD CONSTRAINT `bom_pos_unit_of_measure_id_foreign` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `unit_of_measures`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_additional_heat_treatments` ADD CONSTRAINT `calculation_additional_heat_treatments_calculation_id_foreign` FOREIGN KEY (`calculation_id`) REFERENCES `calculations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_chem_analyses` ADD CONSTRAINT `calculation_chem_analyses_calculation_id_foreign` FOREIGN KEY (`calculation_id`) REFERENCES `calculations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_chem_analyses` ADD CONSTRAINT `calculation_chem_analyses_chem_analysis_id_foreign` FOREIGN KEY (`chem_analysis_id`) REFERENCES `chem_analyses`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_chemical_analyses` ADD CONSTRAINT `calculation_chemical_analyses_cma_frn` FOREIGN KEY (`calculation_material_analysis_id`) REFERENCES `calculation_material_analyses`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_deformations` ADD CONSTRAINT `calculation_deformations_calculation_id_foreign` FOREIGN KEY (`calculation_id`) REFERENCES `calculations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_deformations` ADD CONSTRAINT `calculation_deformations_deformation_id_foreign` FOREIGN KEY (`deformation_id`) REFERENCES `deformations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_documentation_certificates` ADD CONSTRAINT `calculation_documentation_id_foreign` FOREIGN KEY (`calculation_documentation_id`) REFERENCES `calculation_documentations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_documentations` ADD CONSTRAINT `calculation_documentations_calculation_id_foreign` FOREIGN KEY (`calculation_id`) REFERENCES `calculations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_documentations` ADD CONSTRAINT `calculation_documentations_documentation_id_foreign` FOREIGN KEY (`documentation_id`) REFERENCES `documentations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_hardenability_range_material` ADD CONSTRAINT `chrm_calc_harden_ability_range_id_foreign` FOREIGN KEY (`calculation_hardenability_range_id`) REFERENCES `calculation_hardenability_ranges`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_hardenability_range_material` ADD CONSTRAINT `chrm_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_hardenability_ranges` ADD CONSTRAINT `calculation_hardenability_ranges_calculation_id_foreign` FOREIGN KEY (`calculation_id`) REFERENCES `calculations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_hardenability_ranges` ADD CONSTRAINT `calculation_hardenability_ranges_hardenability_range_id_foreign` FOREIGN KEY (`hardenability_range_id`) REFERENCES `hardenability_ranges`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_heat_treatments` ADD CONSTRAINT `calculation_heat_treatments_calculation_id_foreign` FOREIGN KEY (`calculation_id`) REFERENCES `calculations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_material_analyses` ADD CONSTRAINT `calculation_material_analyses_calculation_id_foreign` FOREIGN KEY (`calculation_id`) REFERENCES `calculations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_material_analyses` ADD CONSTRAINT `calculation_material_analyses_material_analysis_id_foreign` FOREIGN KEY (`material_analysis_id`) REFERENCES `material_analyses`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_material_analysis_material` ADD CONSTRAINT `cmam_calc_material_analyses_id_foreign` FOREIGN KEY (`calculation_material_analysis_id`) REFERENCES `calculation_material_analyses`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_material_analysis_material` ADD CONSTRAINT `cmam_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_metallographies` ADD CONSTRAINT `calculation_metallographies_calculation_id_foreign` FOREIGN KEY (`calculation_id`) REFERENCES `calculations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_metallographies` ADD CONSTRAINT `metallography_id_foreign` FOREIGN KEY (`metallography_id`) REFERENCES `metallographies`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_metallography_cleanliness_determination_accordings` ADD CONSTRAINT `calculation_metallography_id_foreign_cdat` FOREIGN KEY (`calculation_metallography_id`) REFERENCES `calculation_metallographies`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_non_destructive_norms` ADD CONSTRAINT `calculation_non_destructive_testing_id_foreign_key` FOREIGN KEY (`calculation_non_destructive_testing_id`) REFERENCES `calculation_non_destructive_testings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_non_destructive_testing_attestation_entities` ADD CONSTRAINT `calculation_non_destructive_testing_id_foreign` FOREIGN KEY (`calculation_non_destructive_testing_id`) REFERENCES `calculation_non_destructive_testings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_non_destructive_testing_surface_attestation_entities` ADD CONSTRAINT `cal_non_dest_surface_testing_id_foreign` FOREIGN KEY (`calculation_non_destructive_testing_id`) REFERENCES `calculation_non_destructive_testings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_non_destructive_testings` ADD CONSTRAINT `calculation_non_destructive_testings_calculation_id_foreign` FOREIGN KEY (`calculation_id`) REFERENCES `calculations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_non_destructive_testings` ADD CONSTRAINT `calculation_non_destructive_testings_us_norm_id_foreign` FOREIGN KEY (`us_norm_id`) REFERENCES `us_norms`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_non_destructive_testings` ADD CONSTRAINT `non_destructive_testing_id_foreign` FOREIGN KEY (`non_destructive_testing_id`) REFERENCES `non_destructive_testings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_residual_materials` ADD CONSTRAINT `calculation_residual_materials_calculation_id_foreign` FOREIGN KEY (`calculation_id`) REFERENCES `calculations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_residual_materials` ADD CONSTRAINT `calculation_residual_materials_residual_material_id_foreign` FOREIGN KEY (`residual_material_id`) REFERENCES `residual_materials`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_testing_scope_according_to_impact_tests` ADD CONSTRAINT `calculation_testing_scope_id_foreign_for_impact_test` FOREIGN KEY (`calculation_testing_scope_id`) REFERENCES `calculation_testing_scopes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_testing_scope_according_to_tensile_tests` ADD CONSTRAINT `calculation_testing_scope_id_foreign_for_tensile_tests` FOREIGN KEY (`calculation_testing_scope_id`) REFERENCES `calculation_testing_scopes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_testing_scope_attestation_entities` ADD CONSTRAINT `calculation_testing_scope_id_foreignentities` FOREIGN KEY (`calculation_testing_scope_id`) REFERENCES `calculation_testing_scopes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_testing_scope_classified_bies` ADD CONSTRAINT `calculation_testing_scope_classified_bies_cts_id` FOREIGN KEY (`calculation_testing_scope_id`) REFERENCES `calculation_testing_scopes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_testing_scope_melting_types` ADD CONSTRAINT `fk_melting_type_scope` FOREIGN KEY (`calculation_testing_scope_id`) REFERENCES `calculation_testing_scopes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_testing_scope_sample_depths` ADD CONSTRAINT `fk_scope_sample_depth` FOREIGN KEY (`calculation_testing_scope_id`) REFERENCES `calculation_testing_scopes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_testing_scopes` ADD CONSTRAINT `calculation_testing_scopes_calculation_id_foreign` FOREIGN KEY (`calculation_id`) REFERENCES `calculations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculation_testing_scopes` ADD CONSTRAINT `calculation_testing_scopes_testing_scope_id_foreign` FOREIGN KEY (`testing_scope_id`) REFERENCES `testing_scopes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_bom_id_foreign` FOREIGN KEY (`bom_id`) REFERENCES `boms`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_deformation_id_foreign` FOREIGN KEY (`deformation_id`) REFERENCES `deformations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_deformation_individual_id_foreign` FOREIGN KEY (`deformation_individual_id`) REFERENCES `deformations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_documentation_id_foreign` FOREIGN KEY (`documentation_id`) REFERENCES `documentations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_hardenability_range_id_foreign` FOREIGN KEY (`hardenability_range_id`) REFERENCES `hardenability_ranges`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_hwe_work_plan_id_foreign` FOREIGN KEY (`hwe_work_plan_id`) REFERENCES `hwe_work_plans`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_material_analysis_id_foreign` FOREIGN KEY (`material_analysis_id`) REFERENCES `material_analyses`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_metallography_id_foreign` FOREIGN KEY (`metallography_id`) REFERENCES `metallographies`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_non_destructive_testing_id_foreign` FOREIGN KEY (`non_destructive_testing_id`) REFERENCES `non_destructive_testings`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_non_destructive_testing_individual_id_foreign` FOREIGN KEY (`non_destructive_testing_individual_id`) REFERENCES `non_destructive_testings`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_offer_pos_id_foreign` FOREIGN KEY (`offer_pos_id`) REFERENCES `offer_pos`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_operation_plan_id_foreign` FOREIGN KEY (`operation_plan_id`) REFERENCES `operation_plans`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_residual_material_id_foreign` FOREIGN KEY (`residual_material_id`) REFERENCES `residual_materials`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_specification_id_foreign` FOREIGN KEY (`specification_id`) REFERENCES `specifications`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `calculations` ADD CONSTRAINT `calculations_testing_scope_id_foreign` FOREIGN KEY (`testing_scope_id`) REFERENCES `testing_scopes`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `call_offs` ADD CONSTRAINT `call_offs_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `call_offs` ADD CONSTRAINT `call_offs_operation_plan_id_foreign` FOREIGN KEY (`operation_plan_id`) REFERENCES `operation_plans`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `capacities` ADD CONSTRAINT `capacities_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `chat_user` ADD CONSTRAINT `chat_user_chat_id_foreign` FOREIGN KEY (`chat_id`) REFERENCES `chats`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `chat_user` ADD CONSTRAINT `chat_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `contact_person_task` ADD CONSTRAINT `contact_person_task_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `contact_person_task` ADD CONSTRAINT `contact_person_task_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `contactable_contacts` ADD CONSTRAINT `contactable_contacts_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `cost_center_costs` ADD CONSTRAINT `cost_center_costs_cost_center_id_foreign` FOREIGN KEY (`cost_center_id`) REFERENCES `cost_centers`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `crm_customer_plants` ADD CONSTRAINT `crm_customer_plants_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `crm_customer_plants` ADD CONSTRAINT `crm_customer_plants_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customer_crm_action_logs` ADD CONSTRAINT `customer_crm_action_logs_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customer_crm_action_logs` ADD CONSTRAINT `customer_crm_action_logs_crm_action_id_foreign` FOREIGN KEY (`crm_action_id`) REFERENCES `crm_actions`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customer_crm_action_logs` ADD CONSTRAINT `customer_crm_action_logs_crm_priority_id_foreign` FOREIGN KEY (`crm_priority_id`) REFERENCES `crm_priorities`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customer_crm_action_logs` ADD CONSTRAINT `customer_crm_action_logs_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customer_crm_action_logs` ADD CONSTRAINT `customer_crm_action_logs_sales_status_id_foreign` FOREIGN KEY (`sales_status_id`) REFERENCES `sales_statuses`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customer_crm_action_logs` ADD CONSTRAINT `customer_crm_action_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customer_items` ADD CONSTRAINT `customer_items_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customer_items` ADD CONSTRAINT `customer_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customer_market_segments` ADD CONSTRAINT `customer_market_segments_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customer_market_segments` ADD CONSTRAINT `customer_market_segments_market_segment_id_foreign` FOREIGN KEY (`market_segment_id`) REFERENCES `market_segments`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customer_tasks` ADD CONSTRAINT `customer_tasks_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customer_tasks` ADD CONSTRAINT `customer_tasks_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_chat_id_foreign` FOREIGN KEY (`chat_id`) REFERENCES `chats`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_crm_priority_id_foreign` FOREIGN KEY (`crm_priority_id`) REFERENCES `crm_priorities`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_customer_category_id_foreign` FOREIGN KEY (`customer_category_id`) REFERENCES `customer_categories`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_customer_id_head_office_foreign` FOREIGN KEY (`customer_id_head_office`) REFERENCES `customers`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_delivery_term_id_foreign` FOREIGN KEY (`delivery_term_id`) REFERENCES `delivery_terms`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_employee_classification_id_foreign` FOREIGN KEY (`employee_classification_id`) REFERENCES `employee_classifications`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_machine_classification_id_foreign` FOREIGN KEY (`machine_classification_id`) REFERENCES `machine_classifications`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_market_segment_id_foreign` FOREIGN KEY (`market_segment_id`) REFERENCES `market_segments`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_payment_term_id_foreign` FOREIGN KEY (`payment_term_id`) REFERENCES `payment_terms`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_potential_classification_id_foreign` FOREIGN KEY (`potential_classification_id`) REFERENCES `potential_classifications`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_revenue_classification_id_foreign` FOREIGN KEY (`revenue_classification_id`) REFERENCES `revenue_classifications`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_sales_area_id_foreign` FOREIGN KEY (`sales_area_id`) REFERENCES `sales_areas`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_sales_group_id_foreign` FOREIGN KEY (`sales_group_id`) REFERENCES `sales_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_sales_status_id_foreign` FOREIGN KEY (`sales_status_id`) REFERENCES `sales_statuses`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_sector_id_foreign` FOREIGN KEY (`sector_id`) REFERENCES `sectors`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `customers` ADD CONSTRAINT `customers_user_id_responsible_foreign` FOREIGN KEY (`user_id_responsible`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `department_hall` ADD CONSTRAINT `department_hall_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `department_hall` ADD CONSTRAINT `department_hall_hall_id_foreign` FOREIGN KEY (`hall_id`) REFERENCES `halls`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `doc_visu_directory_versions` ADD CONSTRAINT `doc_visu_directory_versions_doc_visu_directory_id_foreign` FOREIGN KEY (`doc_visu_directory_id`) REFERENCES `doc_visu_directories`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `doc_visu_directory_versions` ADD CONSTRAINT `doc_visu_directory_versions_user_id_creator_foreign` FOREIGN KEY (`user_id_creator`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `doc_visu_files` ADD CONSTRAINT `doc_visu_files_user_id_released_by_foreign` FOREIGN KEY (`user_id_released_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `document_sections` ADD CONSTRAINT `document_sections_directory_structure_id_foreign` FOREIGN KEY (`directory_structure_id`) REFERENCES `directory_structures`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `documentation_certificates` ADD CONSTRAINT `documentation_certificates_documentation_id_foreign` FOREIGN KEY (`documentation_id`) REFERENCES `documentations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `eight_d_report_actions` ADD CONSTRAINT `eight_d_report_actions_eight_d_report_id_foreign` FOREIGN KEY (`eight_d_report_id`) REFERENCES `eight_d_reports`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `eight_d_report_actions` ADD CONSTRAINT `eight_d_report_actions_responsible_id_foreign` FOREIGN KEY (`responsible_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `eight_d_report_five_whies` ADD CONSTRAINT `eight_d_report_five_whies_eight_d_report_id_foreign` FOREIGN KEY (`eight_d_report_id`) REFERENCES `eight_d_reports`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `eight_d_report_ishikawas` ADD CONSTRAINT `eight_d_report_ishikawas_eight_d_report_id_foreign` FOREIGN KEY (`eight_d_report_id`) REFERENCES `eight_d_reports`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `eight_d_report_teams` ADD CONSTRAINT `eight_d_report_teams_eight_d_report_id_foreign` FOREIGN KEY (`eight_d_report_id`) REFERENCES `eight_d_reports`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `eight_d_report_teams` ADD CONSTRAINT `eight_d_report_teams_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `eight_d_reports` ADD CONSTRAINT `eight_d_reports_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `eight_d_reports` ADD CONSTRAINT `eight_d_reports_chat_id_foreign` FOREIGN KEY (`chat_id`) REFERENCES `chats`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `eight_d_reports` ADD CONSTRAINT `eight_d_reports_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plants`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `eight_d_reports` ADD CONSTRAINT `eight_d_reports_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `energy_consumer_machines` ADD CONSTRAINT `energy_consumer_machines_energy_consumer_id_foreign` FOREIGN KEY (`energy_consumer_id`) REFERENCES `energy_consumers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `energy_consumer_machines` ADD CONSTRAINT `energy_consumer_machines_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `energy_consumers` ADD CONSTRAINT `energy_consumers_energy_consumer_group_id_foreign` FOREIGN KEY (`energy_consumer_group_id`) REFERENCES `energy_consumer_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `energy_consumptions` ADD CONSTRAINT `energy_consumptions_energy_consumer_id_foreign` FOREIGN KEY (`energy_consumer_id`) REFERENCES `energy_consumers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `energy_impeller_consumptions` ADD CONSTRAINT `energy_impeller_consumptions_energy_consumer_id_foreign` FOREIGN KEY (`energy_consumer_id`) REFERENCES `energy_consumers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `energy_impeller_consumptions` ADD CONSTRAINT `energy_impeller_consumptions_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `energy_meter_readings` ADD CONSTRAINT `energy_meter_readings_energy_consumer_id_foreign` FOREIGN KEY (`energy_consumer_id`) REFERENCES `energy_consumers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `energy_meter_readings` ADD CONSTRAINT `energy_meter_readings_energy_meter_id_foreign` FOREIGN KEY (`energy_meter_id`) REFERENCES `energy_meters`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `energy_meters` ADD CONSTRAINT `energy_meters_energy_consumer_id_foreign` FOREIGN KEY (`energy_consumer_id`) REFERENCES `energy_consumers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment` ADD CONSTRAINT `equipment_calibration_standard_id_foreign` FOREIGN KEY (`calibration_standard_id`) REFERENCES `calibration_standards`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment` ADD CONSTRAINT `equipment_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment` ADD CONSTRAINT `equipment_equipment_id_parent_foreign` FOREIGN KEY (`equipment_id_parent`) REFERENCES `equipment`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment` ADD CONSTRAINT `equipment_equipment_status_id_foreign` FOREIGN KEY (`equipment_status_id`) REFERENCES `equipment_statuses`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment` ADD CONSTRAINT `equipment_item_id_date_stamp_foreign` FOREIGN KEY (`item_id_date_stamp`) REFERENCES `items`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment` ADD CONSTRAINT `equipment_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment` ADD CONSTRAINT `equipment_item_id_spare_year_change_foreign` FOREIGN KEY (`item_id_spare_year_change`) REFERENCES `items`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment` ADD CONSTRAINT `equipment_storage_bin_id_foreign` FOREIGN KEY (`storage_bin_id`) REFERENCES `storage_bins`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment` ADD CONSTRAINT `equipment_storage_bin_id_gripper_foreign` FOREIGN KEY (`storage_bin_id_gripper`) REFERENCES `storage_bins`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment_equipment_groups` ADD CONSTRAINT `equipment_equipment_groups_equipment_group_id_foreign` FOREIGN KEY (`equipment_group_id`) REFERENCES `equipment_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment_equipment_groups` ADD CONSTRAINT `equipment_equipment_groups_equipment_id_foreign` FOREIGN KEY (`equipment_id`) REFERENCES `equipment`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment_item` ADD CONSTRAINT `equipment_item_equipment_id_foreign` FOREIGN KEY (`equipment_id`) REFERENCES `equipment`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment_item` ADD CONSTRAINT `equipment_item_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment_machine` ADD CONSTRAINT `equipment_machine_equipment_id_foreign` FOREIGN KEY (`equipment_id`) REFERENCES `equipment`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `equipment_machine` ADD CONSTRAINT `equipment_machine_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `favorites` ADD CONSTRAINT `favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `fcm_tokens` ADD CONSTRAINT `fcm_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `file_notes` ADD CONSTRAINT `file_notes_doc_visu_file_id_foreign` FOREIGN KEY (`doc_visu_file_id`) REFERENCES `doc_visu_files`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `file_notes` ADD CONSTRAINT `file_notes_user_id_creator_foreign` FOREIGN KEY (`user_id_creator`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `file_versions` ADD CONSTRAINT `file_versions_doc_visu_file_id_foreign` FOREIGN KEY (`doc_visu_file_id`) REFERENCES `doc_visu_files`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `file_versions` ADD CONSTRAINT `file_versions_media_file_id_foreign` FOREIGN KEY (`media_file_id`) REFERENCES `media`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `file_versions` ADD CONSTRAINT `file_versions_user_id_creator_foreign` FOREIGN KEY (`user_id_creator`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hall_capacity_settings` ADD CONSTRAINT `hall_capacity_settings_hall_id_foreign` FOREIGN KEY (`hall_id`) REFERENCES `halls`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `handling_unit_prod_order_pos_operation_consumptions` ADD CONSTRAINT `h_u_prod_order_pos_operation_consumptions_p_o_p_o_c_foreign` FOREIGN KEY (`prod_order_pos_operation_consumption_id`) REFERENCES `prod_order_pos_operation_consumptions`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `handling_unit_prod_order_pos_operation_consumptions` ADD CONSTRAINT `handling_unit_prod_order_pos_operation_consumptions_h_u_foreign` FOREIGN KEY (`handling_unit_id`) REFERENCES `handling_units`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `handling_units` ADD CONSTRAINT `handling_units_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `handling_units` ADD CONSTRAINT `handling_units_packaging_instruction_id_foreign` FOREIGN KEY (`packaging_instruction_id`) REFERENCES `packaging_instructions`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hardenability_range_material` ADD CONSTRAINT `ham_harden_ability_range_id_foreign` FOREIGN KEY (`hardenability_range_id`) REFERENCES `hardenability_ranges`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hardenability_range_material` ADD CONSTRAINT `ham_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_additional_cost_triggers` ADD CONSTRAINT `hwe_additional_cost_triggers_hwe_additional_cost_id_foreign` FOREIGN KEY (`hwe_additional_cost_id`) REFERENCES `hwe_additional_costs`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_certificate_hwe_qs_samples` ADD CONSTRAINT `hwe_certificate_hwe_qs_samples_hwe_certificate_id_foreign` FOREIGN KEY (`hwe_certificate_id`) REFERENCES `hwe_certificates`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_certificate_hwe_qs_samples` ADD CONSTRAINT `hwe_certificate_hwe_qs_samples_hwe_qs_sample_id_foreign` FOREIGN KEY (`hwe_qs_sample_id`) REFERENCES `hwe_qs_samples`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_certificates` ADD CONSTRAINT `hwe_certificates_prod_order_pos_id_heat_treatment_foreign` FOREIGN KEY (`prod_order_pos_id_heat_treatment`) REFERENCES `prod_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_certificates` ADD CONSTRAINT `hwe_certificates_prod_order_pos_id_qs_samples_foreign` FOREIGN KEY (`prod_order_pos_id_qs_samples`) REFERENCES `prod_order_pos`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_certificates` ADD CONSTRAINT `hwe_certificates_prod_order_pos_id_surface_foreign` FOREIGN KEY (`prod_order_pos_id_surface`) REFERENCES `prod_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_certificates` ADD CONSTRAINT `hwe_certificates_prod_order_pos_id_ultrasonic_foreign` FOREIGN KEY (`prod_order_pos_id_ultrasonic`) REFERENCES `prod_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_freight_costs` ADD CONSTRAINT `hwe_freight_costs_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_kalk_logs` ADD CONSTRAINT `hwe_kalk_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_melt_analyses` ADD CONSTRAINT `hwe_melt_analyses_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_melt_analyses` ADD CONSTRAINT `hwe_melt_analyses_material_analysis_id_foreign` FOREIGN KEY (`material_analysis_id`) REFERENCES `material_analyses`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_offer_pos_work_plan_lead_times` ADD CONSTRAINT `hwe_offer_pos_work_plan_lead_times_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_packaging_cost_product_types` ADD CONSTRAINT `hwe_packaging_cost_product_types_hwe_packaging_cost_id_foreign` FOREIGN KEY (`hwe_packaging_cost_id`) REFERENCES `hwe_packaging_costs`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_prod_order_pos_operation_oven_protocols` ADD CONSTRAINT `hwe_prod_order_pos_operation_oven_protocols_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_prod_order_pos_operation_oven_protocols` ADD CONSTRAINT `oven_protocols_position_machine_id_foreign` FOREIGN KEY (`machine_id_position`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_prod_order_pos_operation_oven_protocols` ADD CONSTRAINT `oven_protocols_source_machine_id_foreign` FOREIGN KEY (`machine_id_source`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_prod_order_pos_operation_oven_protocols` ADD CONSTRAINT `prod_order_pos_operation_id_foreign_for_oven_protocols` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_cleanliness_tests` ADD CONSTRAINT `hwe_qs_cleanliness_tests_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_cleanliness_tests` ADD CONSTRAINT `hwe_qs_cleanliness_tests_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_cleanliness_tests` ADD CONSTRAINT `hwe_qs_cleanliness_tests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_grain_size_tests` ADD CONSTRAINT `hwe_qs_grain_size_tests_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_grain_size_tests` ADD CONSTRAINT `hwe_qs_grain_size_tests_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_grain_size_tests` ADD CONSTRAINT `hwe_qs_grain_size_tests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_hb_pos` ADD CONSTRAINT `hwe_qs_hb_pos_hwe_qs_hb_id_foreign` FOREIGN KEY (`hwe_qs_hb_id`) REFERENCES `hwe_qs_hbs`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_hbs` ADD CONSTRAINT `hwe_qs_hbs_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_hbs` ADD CONSTRAINT `hwe_qs_hbs_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_hbs` ADD CONSTRAINT `hwe_qs_hbs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_impact_test_pos` ADD CONSTRAINT `hwe_qs_impact_test_pos_hwe_qs_impact_test_id_foreign` FOREIGN KEY (`hwe_qs_impact_test_id`) REFERENCES `hwe_qs_impact_tests`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_impact_tests` ADD CONSTRAINT `hwe_qs_impact_tests_hwe_qs_sample_id_foreign` FOREIGN KEY (`hwe_qs_sample_id`) REFERENCES `hwe_qs_samples`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_impact_tests` ADD CONSTRAINT `hwe_qs_impact_tests_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_impact_tests` ADD CONSTRAINT `hwe_qs_impact_tests_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_impact_tests` ADD CONSTRAINT `hwe_qs_impact_tests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_jominy_tests` ADD CONSTRAINT `hwe_qs_jominy_tests_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_jominy_tests` ADD CONSTRAINT `hwe_qs_jominy_tests_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_jominy_tests` ADD CONSTRAINT `hwe_qs_jominy_tests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_mt_norms` ADD CONSTRAINT `hwe_qs_mt_norms_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_mt_norms` ADD CONSTRAINT `hwe_qs_mt_norms_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_mt_norms` ADD CONSTRAINT `hwe_qs_mt_norms_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_pt_norms` ADD CONSTRAINT `hwe_qs_pt_norms_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_pt_norms` ADD CONSTRAINT `hwe_qs_pt_norms_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_pt_norms` ADD CONSTRAINT `hwe_qs_pt_norms_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_samples_prod_order_pos` ADD CONSTRAINT `hwe_qs_samples_prod_order_pos_hwe_qs_sample_id_foreign` FOREIGN KEY (`hwe_qs_sample_id`) REFERENCES `hwe_qs_samples`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_samples_prod_order_pos` ADD CONSTRAINT `hwe_qs_samples_prod_order_pos_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_tensile_tests` ADD CONSTRAINT `hwe_qs_tensile_tests_hwe_qs_sample_id_foreign` FOREIGN KEY (`hwe_qs_sample_id`) REFERENCES `hwe_qs_samples`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_tensile_tests` ADD CONSTRAINT `hwe_qs_tensile_tests_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_tensile_tests` ADD CONSTRAINT `hwe_qs_tensile_tests_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_tensile_tests` ADD CONSTRAINT `hwe_qs_tensile_tests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_us_norm_adjustments` ADD CONSTRAINT `hwe_qs_us_norm_adjustments_hwe_qs_us_norm_id_foreign` FOREIGN KEY (`hwe_qs_us_norm_id`) REFERENCES `hwe_qs_us_norms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_us_norm_rating_justifications` ADD CONSTRAINT `hwe_qs_norm_rating_idx` FOREIGN KEY (`hwe_qs_us_norm_rating_id`) REFERENCES `hwe_qs_us_norm_ratings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_us_norm_ratings` ADD CONSTRAINT `hwe_qs_us_norm_ratings_hwe_qs_us_norm_id_foreign` FOREIGN KEY (`hwe_qs_us_norm_id`) REFERENCES `hwe_qs_us_norms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_us_norm_test_scopes` ADD CONSTRAINT `hwe_qs_us_norm_test_scopes_hwe_qs_us_norm_id_foreign` FOREIGN KEY (`hwe_qs_us_norm_id`) REFERENCES `hwe_qs_us_norms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_us_norm_test_sections` ADD CONSTRAINT `hwe_qs_us_norm_test_sections_hwe_qs_us_norm_id_foreign` FOREIGN KEY (`hwe_qs_us_norm_id`) REFERENCES `hwe_qs_us_norms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_us_norms` ADD CONSTRAINT `hwe_qs_us_norms_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_us_norms` ADD CONSTRAINT `hwe_qs_us_norms_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_us_norms` ADD CONSTRAINT `hwe_qs_us_norms_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_vt_norm_auxiliary_means` ADD CONSTRAINT `hwe_qs_vt_norm_auxiliary_means_hwe_qs_vt_norm_id_foreign` FOREIGN KEY (`hwe_qs_vt_norm_id`) REFERENCES `hwe_qs_vt_norms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_vt_norm_test_techniques` ADD CONSTRAINT `hwe_qs_vt_norm_test_techniques_hwe_qs_vt_norm_id_foreign` FOREIGN KEY (`hwe_qs_vt_norm_id`) REFERENCES `hwe_qs_vt_norms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_vt_norms` ADD CONSTRAINT `hwe_qs_vt_norms_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_vt_norms` ADD CONSTRAINT `hwe_qs_vt_norms_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_qs_vt_norms` ADD CONSTRAINT `hwe_qs_vt_norms_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_work_plan_additional_heat_treatments` ADD CONSTRAINT `hwe_work_plan_add_treat_hwe_work_plan_id_foreign` FOREIGN KEY (`hwe_work_plan_id`) REFERENCES `hwe_work_plans`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `hwe_work_plan_heat_treatments` ADD CONSTRAINT `hwe_work_plan_heat_treatments_hwe_work_plan_id_foreign` FOREIGN KEY (`hwe_work_plan_id`) REFERENCES `hwe_work_plans`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_lots` ADD CONSTRAINT `inspection_lots_item_plant_id_foreign` FOREIGN KEY (`item_plant_id`) REFERENCES `item_plants`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_operation_characteristic_options` ADD CONSTRAINT `option_attribute_set_foreign` FOREIGN KEY (`attribute_set_option_id`) REFERENCES `attribute_set_options`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_operation_characteristic_options` ADD CONSTRAINT `option_characteristic_foreign` FOREIGN KEY (`inspection_operation_characteristic_id`) REFERENCES `inspection_operation_characteristics`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_operation_characteristics` ADD CONSTRAINT `fk_char_unit_of_measure_id_sample` FOREIGN KEY (`unit_of_measure_id_sample`) REFERENCES `unit_of_measures`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_operation_characteristics` ADD CONSTRAINT `fk_char_unit_of_measure_id_value` FOREIGN KEY (`unit_of_measure_id_value`) REFERENCES `unit_of_measures`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_operation_characteristics` ADD CONSTRAINT `inspection_operation_characteristics_attribute_set_id_foreign` FOREIGN KEY (`attribute_set_id`) REFERENCES `attribute_sets`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_operation_characteristics` ADD CONSTRAINT `inspection_operation_characteristics_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_operation_characteristics` ADD CONSTRAINT `ioc_isimportancecode_fk` FOREIGN KEY (`inspection_specification_importance_code_id`) REFERENCES `inspection_specification_importance_codes`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_plans` ADD CONSTRAINT `inspection_plans_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_plans` ADD CONSTRAINT `inspection_plans_operation_plan_pos_id_foreign` FOREIGN KEY (`operation_plan_pos_id`) REFERENCES `operation_plan_pos`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_point_characteristic_options` ADD CONSTRAINT `point_char_opt_ope_char_opt_foreign` FOREIGN KEY (`inspection_operation_characteristic_option_id`) REFERENCES `inspection_operation_characteristic_options`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_point_characteristic_options` ADD CONSTRAINT `point_char_opt_point_char_foreign` FOREIGN KEY (`inspection_point_characteristic_id`) REFERENCES `inspection_point_characteristics`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_point_characteristics` ADD CONSTRAINT `inspection_point_characteristics_inspection_point_id_foreign` FOREIGN KEY (`inspection_point_id`) REFERENCES `inspection_points`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_point_characteristics` ADD CONSTRAINT `inspection_point_characteristics_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_point_characteristics` ADD CONSTRAINT `point_char_operation_char_foreign` FOREIGN KEY (`inspection_operation_characteristic_id`) REFERENCES `inspection_operation_characteristics`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_points` ADD CONSTRAINT `inspection_points_capacity_id_trigger_foreign` FOREIGN KEY (`capacity_id_trigger`) REFERENCES `capacities`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_points` ADD CONSTRAINT `inspection_points_inspection_lot_id_foreign` FOREIGN KEY (`inspection_lot_id`) REFERENCES `inspection_lots`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_points` ADD CONSTRAINT `inspection_points_machine_cycle_id_trigger_foreign` FOREIGN KEY (`machine_cycle_id_trigger`) REFERENCES `machine_cycles`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_points` ADD CONSTRAINT `inspection_points_user_id_creator_foreign` FOREIGN KEY (`user_id_creator`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_specifications` ADD CONSTRAINT `inspection_specifications_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plants`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `inspection_specifications` ADD CONSTRAINT `is_isimportance_code_fk` FOREIGN KEY (`inspection_specification_importance_code_id`) REFERENCES `inspection_specification_importance_codes`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_bom_children` ADD CONSTRAINT `item_bom_children_child_item_id_foreign` FOREIGN KEY (`child_item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_bom_children` ADD CONSTRAINT `item_bom_children_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_packaging_items` ADD CONSTRAINT `item_packaging_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_packaging_items` ADD CONSTRAINT `item_packaging_items_packaging_item_id_foreign` FOREIGN KEY (`packaging_item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_plant_storage_locations` ADD CONSTRAINT `item_plant_storage_locations_item_plant_id_foreign` FOREIGN KEY (`item_plant_id`) REFERENCES `item_plants`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_plant_storage_locations` ADD CONSTRAINT `item_plant_storage_locations_storage_location_id_foreign` FOREIGN KEY (`storage_location_id`) REFERENCES `storage_locations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_plants` ADD CONSTRAINT `item_plant_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_plants` ADD CONSTRAINT `item_plant_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plants`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_plants` ADD CONSTRAINT `item_plants_serial_number_profile_id_foreign` FOREIGN KEY (`serial_number_profile_id`) REFERENCES `serial_number_profiles`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_plants` ADD CONSTRAINT `item_plants_storage_location_id_foreign` FOREIGN KEY (`storage_location_id`) REFERENCES `storage_locations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_plants` ADD CONSTRAINT `item_plants_storage_location_id_rework_foreign` FOREIGN KEY (`storage_location_id_rework`) REFERENCES `storage_locations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_plants` ADD CONSTRAINT `item_plants_storage_location_id_scrap_foreign` FOREIGN KEY (`storage_location_id_scrap`) REFERENCES `storage_locations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_state_halls` ADD CONSTRAINT `bad_part_reasons_halls_hall_id_foreign` FOREIGN KEY (`hall_id`) REFERENCES `halls`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_state_halls` ADD CONSTRAINT `item_state_halls_item_state_id_foreign` FOREIGN KEY (`item_state_id`) REFERENCES `item_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_state_machines` ADD CONSTRAINT `bad_part_reason_machines_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_state_machines` ADD CONSTRAINT `item_state_machines_item_state_id_foreign` FOREIGN KEY (`item_state_id`) REFERENCES `item_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_states` ADD CONSTRAINT `item_states_item_state_group_id_foreign` FOREIGN KEY (`item_state_group_id`) REFERENCES `item_state_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_tasks` ADD CONSTRAINT `item_tasks_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_tasks` ADD CONSTRAINT `item_tasks_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_unit_of_measure_conversions` ADD CONSTRAINT `item_unit_of_measure_conversions_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `item_unit_of_measure_conversions` ADD CONSTRAINT `item_unit_of_measure_conversions_unit_of_measure_id_foreign` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `unit_of_measures`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `items` ADD CONSTRAINT `items_bom_id_foreign` FOREIGN KEY (`bom_id`) REFERENCES `boms`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `items` ADD CONSTRAINT `items_item_group_id_foreign` FOREIGN KEY (`item_group_id`) REFERENCES `item_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `items` ADD CONSTRAINT `items_item_type_id_foreign` FOREIGN KEY (`item_type_id`) REFERENCES `item_types`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `items` ADD CONSTRAINT `items_operation_plan_id_foreign` FOREIGN KEY (`operation_plan_id`) REFERENCES `operation_plans`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `items` ADD CONSTRAINT `items_packaging_instruction_id_1_foreign` FOREIGN KEY (`packaging_instruction_id_1`) REFERENCES `packaging_instructions`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `items` ADD CONSTRAINT `items_packaging_instruction_id_2_foreign` FOREIGN KEY (`packaging_instruction_id_2`) REFERENCES `packaging_instructions`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `items` ADD CONSTRAINT `items_packaging_instruction_id_3_foreign` FOREIGN KEY (`packaging_instruction_id_3`) REFERENCES `packaging_instructions`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `items` ADD CONSTRAINT `items_packaging_instruction_id_4_foreign` FOREIGN KEY (`packaging_instruction_id_4`) REFERENCES `packaging_instructions`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `items` ADD CONSTRAINT `items_packaging_instruction_id_foreign` FOREIGN KEY (`packaging_instruction_id`) REFERENCES `packaging_instructions`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `items` ADD CONSTRAINT `items_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plants`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `items` ADD CONSTRAINT `items_unit_of_measure_id_foreign` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `unit_of_measures`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_calendar_exceptions` ADD CONSTRAINT `jpi_calendar_exceptions_jpi_resource_id_foreign` FOREIGN KEY (`jpi_resource_id`) REFERENCES `jpi_resources`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_job_predecessors` ADD CONSTRAINT `jpi_job_predecessors_jpi_job_id_foreign` FOREIGN KEY (`jpi_job_id`) REFERENCES `jpi_jobs`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_job_predecessors` ADD CONSTRAINT `jpi_job_predecessors_predecessor_jpi_job_id_foreign` FOREIGN KEY (`predecessor_jpi_job_id`) REFERENCES `jpi_jobs`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_job_tasks` ADD CONSTRAINT `jpi_job_tasks_jpi_job_id_foreign` FOREIGN KEY (`jpi_job_id`) REFERENCES `jpi_jobs`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_job_tasks` ADD CONSTRAINT `jpi_job_tasks_jpi_task_id_foreign` FOREIGN KEY (`jpi_task_id`) REFERENCES `jpi_tasks`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_job_template_tasks` ADD CONSTRAINT `jpi_job_template_tasks_jpi_job_template_id_foreign` FOREIGN KEY (`jpi_job_template_id`) REFERENCES `jpi_job_templates`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_job_template_tasks` ADD CONSTRAINT `jpi_job_template_tasks_jpi_task_id_foreign` FOREIGN KEY (`jpi_task_id`) REFERENCES `jpi_tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_resource_groups` ADD CONSTRAINT `jpi_resource_groups_jpi_resource_category_id_foreign` FOREIGN KEY (`jpi_resource_category_id`) REFERENCES `jpi_resource_categories`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_resource_resource_groups` ADD CONSTRAINT `jpi_resource_resource_groups_jpi_resource_group_id_foreign` FOREIGN KEY (`jpi_resource_group_id`) REFERENCES `jpi_resource_groups`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_resource_resource_groups` ADD CONSTRAINT `jpi_resource_resource_groups_jpi_resource_id_foreign` FOREIGN KEY (`jpi_resource_id`) REFERENCES `jpi_resources`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_task_assigned_resources` ADD CONSTRAINT `jpi_task_assigned_resources_jpi_resource_id_foreign` FOREIGN KEY (`jpi_resource_id`) REFERENCES `jpi_resources`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_task_assigned_resources` ADD CONSTRAINT `jpi_task_assigned_resources_jpi_task_id_foreign` FOREIGN KEY (`jpi_task_id`) REFERENCES `jpi_tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_task_predecessors` ADD CONSTRAINT `jpi_task_predecessors_jpi_task_id_foreign` FOREIGN KEY (`jpi_task_id`) REFERENCES `jpi_tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_task_predecessors` ADD CONSTRAINT `jpi_task_predecessors_predecessor_jpi_task_id_foreign` FOREIGN KEY (`predecessor_jpi_task_id`) REFERENCES `jpi_tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_task_resource_group_constraint_resource_constraints` ADD CONSTRAINT `jpi_resource_id_foreign` FOREIGN KEY (`jpi_resource_id`) REFERENCES `jpi_resources`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_task_resource_group_constraint_resource_constraints` ADD CONSTRAINT `jpi_task_resource_group_constraint_id_foreign` FOREIGN KEY (`jpi_task_resource_group_constraint_id`) REFERENCES `jpi_task_resource_group_constraints`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_task_resource_group_constraints` ADD CONSTRAINT `jpi_resource_group_id_foreign` FOREIGN KEY (`jpi_resource_group_id`) REFERENCES `jpi_resource_groups`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_task_resource_group_constraints` ADD CONSTRAINT `jpi_task_id_foreign` FOREIGN KEY (`jpi_task_id`) REFERENCES `jpi_tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_tasks` ADD CONSTRAINT `jpi_tasks_assigned_resource1` FOREIGN KEY (`assigned_resource1`) REFERENCES `jpi_resources`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_tasks` ADD CONSTRAINT `jpi_tasks_assigned_resource2` FOREIGN KEY (`assigned_resource2`) REFERENCES `jpi_resources`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_tasks` ADD CONSTRAINT `jpi_tasks_assigned_resource_group1` FOREIGN KEY (`assigned_resource_group1`) REFERENCES `jpi_resource_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_tasks` ADD CONSTRAINT `jpi_tasks_assigned_resource_group2` FOREIGN KEY (`assigned_resource_group2`) REFERENCES `jpi_resource_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_tasks` ADD CONSTRAINT `jpi_tasks_processing_resource1` FOREIGN KEY (`processing_resource1`) REFERENCES `jpi_resources`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_tasks` ADD CONSTRAINT `jpi_tasks_processing_resource2` FOREIGN KEY (`processing_resource2`) REFERENCES `jpi_resources`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_tasks` ADD CONSTRAINT `jpi_tasks_processing_resource_group1` FOREIGN KEY (`processing_resource_group1`) REFERENCES `jpi_resource_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_tasks` ADD CONSTRAINT `jpi_tasks_processing_resource_group2` FOREIGN KEY (`processing_resource_group2`) REFERENCES `jpi_resource_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `jpi_work_time_per_weekdays` ADD CONSTRAINT `jpi_work_time_per_weekdays_jpi_resource_id_foreign` FOREIGN KEY (`jpi_resource_id`) REFERENCES `jpi_resources`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_component_serial_number_profiles` ADD CONSTRAINT `machine_component_serial_number_profiles_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_component_serial_number_profiles` ADD CONSTRAINT `machine_component_serial_number_profiles_snp_foreign` FOREIGN KEY (`serial_number_profile_id`) REFERENCES `serial_number_profiles`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_cycles` ADD CONSTRAINT `machine_cycles_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_cycles` ADD CONSTRAINT `machine_cycles_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_daily_expected_quantities` ADD CONSTRAINT `machine_daily_expected_quantities_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_daily_expected_quantities` ADD CONSTRAINT `machine_daily_expected_quantities_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_daily_expected_quantities` ADD CONSTRAINT `machine_daily_expected_quantities_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_groups` ADD CONSTRAINT `machine_groups_cost_center_id_foreign` FOREIGN KEY (`cost_center_id`) REFERENCES `cost_centers`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_groups` ADD CONSTRAINT `machine_groups_hall_id_foreign` FOREIGN KEY (`hall_id`) REFERENCES `halls`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_last_serial_number_profiles` ADD CONSTRAINT `machine_last_serial_number_profiles_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_last_serial_number_profiles` ADD CONSTRAINT `machine_last_serial_number_profiles_snp_foreign` FOREIGN KEY (`serial_number_profile_id`) REFERENCES `serial_number_profiles`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_machine_state_times` ADD CONSTRAINT `machine_machine_state_times_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_machine_state_times` ADD CONSTRAINT `machine_machine_state_times_machine_state_id_foreign` FOREIGN KEY (`machine_state_id`) REFERENCES `machine_states`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_machine_states` ADD CONSTRAINT `machine_machine_states_svk_at_id_foreign` FOREIGN KEY (`standard_value_key_activity_type_id`) REFERENCES `standard_value_key_activity_types`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_machine_states` ADD CONSTRAINT `machine_state_machines_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_machine_states` ADD CONSTRAINT `machine_state_machines_machine_state_id_foreign` FOREIGN KEY (`machine_state_id`) REFERENCES `machine_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_middle_serial_number_profiles` ADD CONSTRAINT `machine_middle_serial_number_profiles_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_middle_serial_number_profiles` ADD CONSTRAINT `machine_middle_serial_number_profiles_snp_foreign` FOREIGN KEY (`serial_number_profile_id`) REFERENCES `serial_number_profiles`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_process_data` ADD CONSTRAINT `machine_process_data_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_process_data_configurations` ADD CONSTRAINT `machine_process_data_configurations_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_process_data_configurations` ADD CONSTRAINT `machine_process_data_configurations_unit_of_measure_id_foreign` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `unit_of_measures`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_prod_order_pos_operation_times` ADD CONSTRAINT `machine_prod_order_pos_operation_times_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_prod_order_pos_operation_times` ADD CONSTRAINT `machine_prod_order_pos_operation_times_user_id_end_foreign` FOREIGN KEY (`user_id_end`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_prod_order_pos_operation_times` ADD CONSTRAINT `machine_prod_order_pos_operation_times_user_id_start_foreign` FOREIGN KEY (`user_id_start`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_prod_order_pos_operation_times` ADD CONSTRAINT `mpo_item_id_packaging_foreign` FOREIGN KEY (`item_id_packaging`) REFERENCES `items`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_prod_order_pos_operation_times` ADD CONSTRAINT `mpo_item_id_packaging_parent_foreign` FOREIGN KEY (`item_id_packaging_parent`) REFERENCES `items`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_prod_order_pos_operation_times` ADD CONSTRAINT `mpo_packaging_instruction_id_foreign` FOREIGN KEY (`packaging_instruction_id`) REFERENCES `packaging_instructions`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_prod_order_pos_operation_times` ADD CONSTRAINT `mpo_packaging_instruction_id_parent_foreign` FOREIGN KEY (`packaging_instruction_id_parent`) REFERENCES `packaging_instructions`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_prod_order_pos_operation_times` ADD CONSTRAINT `prod_order_pos_operation_id_foreign_for_operation_times` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_registered_times` ADD CONSTRAINT `machine_registered_times_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_registered_times` ADD CONSTRAINT `machine_registered_times_machine_state_id_foreign` FOREIGN KEY (`machine_state_id`) REFERENCES `machine_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_registered_times` ADD CONSTRAINT `machine_registered_times_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_registered_times` ADD CONSTRAINT `machine_registered_times_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_registered_times` ADD CONSTRAINT `machine_registered_times_svk_activity_type_id_foreign` FOREIGN KEY (`standard_value_key_activity_type_id`) REFERENCES `standard_value_key_activity_types`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_resource_groups` ADD CONSTRAINT `machine_resource_groups_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_resource_groups` ADD CONSTRAINT `machine_resource_groups_resource_group_id_foreign` FOREIGN KEY (`resource_group_id`) REFERENCES `resource_groups`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_states` ADD CONSTRAINT `machine_states_machine_state_group_id_foreign` FOREIGN KEY (`machine_state_group_id`) REFERENCES `machine_state_groups`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_tasks` ADD CONSTRAINT `machine_tasks_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_tasks` ADD CONSTRAINT `machine_tasks_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_user_plan_times` ADD CONSTRAINT `machine_user_plan_times_capacity_id_foreign` FOREIGN KEY (`capacity_id`) REFERENCES `capacities`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_user_plan_times` ADD CONSTRAINT `machine_user_plan_times_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_user_plan_times` ADD CONSTRAINT `machine_user_plan_times_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_user_restrictions` ADD CONSTRAINT `machine_user_restrictions_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_user_restrictions` ADD CONSTRAINT `machine_user_restrictions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_user_times` ADD CONSTRAINT `machine_user_times_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_user_times` ADD CONSTRAINT `machine_user_times_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_user_times` ADD CONSTRAINT `machine_user_times_standard_value_key_activity_type_id_foreign` FOREIGN KEY (`standard_value_key_activity_type_id`) REFERENCES `standard_value_key_activity_types`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machine_user_times` ADD CONSTRAINT `machine_user_times_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machines` ADD CONSTRAINT `machines_cost_center_id_foreign` FOREIGN KEY (`cost_center_id`) REFERENCES `cost_centers`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machines` ADD CONSTRAINT `machines_hall_id_foreign` FOREIGN KEY (`hall_id`) REFERENCES `halls`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machines` ADD CONSTRAINT `machines_machine_group_id_foreign` FOREIGN KEY (`machine_group_id`) REFERENCES `machine_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machines` ADD CONSTRAINT `machines_machine_state_id_default_available_foreign` FOREIGN KEY (`machine_state_id_default_available`) REFERENCES `machine_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machines` ADD CONSTRAINT `machines_machine_state_id_default_off_foreign` FOREIGN KEY (`machine_state_id_default_off`) REFERENCES `machine_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machines` ADD CONSTRAINT `machines_machine_state_id_default_production_foreign` FOREIGN KEY (`machine_state_id_default_production`) REFERENCES `machine_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machines` ADD CONSTRAINT `machines_machine_state_id_default_setup_foreign` FOREIGN KEY (`machine_state_id_default_setup`) REFERENCES `machine_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machines` ADD CONSTRAINT `machines_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plants`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machines` ADD CONSTRAINT `machines_production_supply_area_id_foreign` FOREIGN KEY (`production_supply_area_id`) REFERENCES `production_supply_areas`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machines` ADD CONSTRAINT `machines_shift_model_id_foreign` FOREIGN KEY (`shift_model_id`) REFERENCES `shift_models`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machines` ADD CONSTRAINT `machines_standard_value_key_id_foreign` FOREIGN KEY (`standard_value_key_id`) REFERENCES `standard_value_keys`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machines` ADD CONSTRAINT `machines_tpm_group_id_foreign` FOREIGN KEY (`tpm_group_id`) REFERENCES `tpm_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `machines` ADD CONSTRAINT `machines_tpm_sub_group_id_foreign` FOREIGN KEY (`tpm_sub_group_id`) REFERENCES `tpm_sub_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `marker_recipe_pos` ADD CONSTRAINT `marker_recipe_pos_marker_recipe_id_foreign` FOREIGN KEY (`marker_recipe_id`) REFERENCES `marker_recipes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `marker_recipe_pos_blocks` ADD CONSTRAINT `marker_recipe_pos_blocks_marker_recipe_pos_id_foreign` FOREIGN KEY (`marker_recipe_pos_id`) REFERENCES `marker_recipe_pos`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `marker_recipes` ADD CONSTRAINT `marker_recipes_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `marker_recipes` ADD CONSTRAINT `marker_recipes_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `material_analysis_chem_analyses` ADD CONSTRAINT `material_analysis_chem_analyses_chem_analysis_id_foreign` FOREIGN KEY (`chem_analysis_id`) REFERENCES `chem_analyses`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `material_analysis_chem_analyses` ADD CONSTRAINT `material_analysis_chem_analyses_material_analysis_id_foreign` FOREIGN KEY (`material_analysis_id`) REFERENCES `material_analyses`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `material_analysis_material` ADD CONSTRAINT `mam_material_analysis_id_foreign` FOREIGN KEY (`material_analysis_id`) REFERENCES `material_analyses`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `material_analysis_material` ADD CONSTRAINT `mam_materials_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `material_consumption_machines` ADD CONSTRAINT `material_consumption_machines_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `material_consumption_machines` ADD CONSTRAINT `material_consumption_machines_material_consumption_id_foreign` FOREIGN KEY (`material_consumption_id`) REFERENCES `material_consumptions`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `material_consumptions` ADD CONSTRAINT `material_consumptions_furnace_id_foreign` FOREIGN KEY (`furnace_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `material_consumptions` ADD CONSTRAINT `material_consumptions_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `material_consumptions` ADD CONSTRAINT `material_consumptions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `material_databases` ADD CONSTRAINT `material_databases_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `meeting_component_meeting_type` ADD CONSTRAINT `meeting_component_meeting_type_meeting_component_id_foreign` FOREIGN KEY (`meeting_component_id`) REFERENCES `meeting_components`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `meeting_component_meeting_type` ADD CONSTRAINT `meeting_component_meeting_type_meeting_type_id_foreign` FOREIGN KEY (`meeting_type_id`) REFERENCES `meeting_types`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `meeting_types` ADD CONSTRAINT `meeting_types_user_id_creator_foreign` FOREIGN KEY (`user_id_creator`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `meeting_types` ADD CONSTRAINT `meeting_types_user_id_updated_by_foreign` FOREIGN KEY (`user_id_updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `meeting_user` ADD CONSTRAINT `meeting_user_meeting_id_foreign` FOREIGN KEY (`meeting_id`) REFERENCES `meetings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `meeting_user` ADD CONSTRAINT `meeting_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `meetings` ADD CONSTRAINT `meetings_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `meetings` ADD CONSTRAINT `meetings_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `meetings` ADD CONSTRAINT `meetings_meeting_type_id_foreign` FOREIGN KEY (`meeting_type_id`) REFERENCES `meeting_types`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `meetings` ADD CONSTRAINT `meetings_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `meetings` ADD CONSTRAINT `meetings_user_id_creator_foreign` FOREIGN KEY (`user_id_creator`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `meetings` ADD CONSTRAINT `meetings_user_id_updated_by_foreign` FOREIGN KEY (`user_id_updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `message_read` ADD CONSTRAINT `message_read_message_id_foreign` FOREIGN KEY (`message_id`) REFERENCES `messages`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `message_read` ADD CONSTRAINT `message_read_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `messages` ADD CONSTRAINT `messages_affected_user_id_foreign` FOREIGN KEY (`affected_user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `messages` ADD CONSTRAINT `messages_chat_id_foreign` FOREIGN KEY (`chat_id`) REFERENCES `chats`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `messages` ADD CONSTRAINT `messages_sender_user_id_foreign` FOREIGN KEY (`sender_user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `metallography_cleanliness_determination_accordings` ADD CONSTRAINT `metallography_id_foreign_cdat` FOREIGN KEY (`metallography_id`) REFERENCES `metallographies`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `model_has_permissions` ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `model_has_roles` ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mp_cost_machines` ADD CONSTRAINT `mp_cost_machines_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mp_cost_machines` ADD CONSTRAINT `mp_cost_machines_mp_cost_id_foreign` FOREIGN KEY (`mp_cost_id`) REFERENCES `mp_costs`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mp_offer_logs` ADD CONSTRAINT `mp_offer_logs_mp_offer_id_foreign` FOREIGN KEY (`mp_offer_id`) REFERENCES `mp_offers`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mp_offer_logs` ADD CONSTRAINT `mp_offer_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mp_offer_pos` ADD CONSTRAINT `mp_offer_pos_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mp_offer_pos` ADD CONSTRAINT `mp_offer_pos_mp_costs_id_foreign` FOREIGN KEY (`mp_costs_id`) REFERENCES `mp_costs`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mp_offer_pos` ADD CONSTRAINT `mp_offer_pos_mp_material_id_foreign` FOREIGN KEY (`mp_material_id`) REFERENCES `mp_materials`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mp_offer_pos` ADD CONSTRAINT `mp_offer_pos_mp_offer_id_foreign` FOREIGN KEY (`mp_offer_id`) REFERENCES `mp_offers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mp_offer_pos` ADD CONSTRAINT `mp_offer_pos_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mp_offers` ADD CONSTRAINT `mp_offers_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mp_offers` ADD CONSTRAINT `mp_offers_final_customer_id_foreign` FOREIGN KEY (`final_customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mp_offers` ADD CONSTRAINT `mp_offers_parent_offer_id_foreign` FOREIGN KEY (`parent_offer_id`) REFERENCES `mp_offers`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mp_offers` ADD CONSTRAINT `mp_offers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mt_norm_control_units` ADD CONSTRAINT `mt_norm_control_units_mt_norm_id_foreign` FOREIGN KEY (`mt_norm_id`) REFERENCES `mt_norms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `non_destructive_norms` ADD CONSTRAINT `non_destructive_norms_non_destructive_testing_id_foreign` FOREIGN KEY (`non_destructive_testing_id`) REFERENCES `non_destructive_testings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `non_destructive_testing_attestation_entities` ADD CONSTRAINT `fk_ndt_attestation_ndt_id` FOREIGN KEY (`non_destructive_testing_id`) REFERENCES `non_destructive_testings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `non_destructive_testing_surface_attestation_entities` ADD CONSTRAINT `fk_ndt_surface_attestation_ndt_id` FOREIGN KEY (`non_destructive_testing_id`) REFERENCES `non_destructive_testings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `non_destructive_testings` ADD CONSTRAINT `non_destructive_testings_us_norm_id_foreign` FOREIGN KEY (`us_norm_id`) REFERENCES `us_norms`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `norm_chem_analyses` ADD CONSTRAINT `norm_chem_analyses_chem_analyses_id_foreign` FOREIGN KEY (`chem_analyses_id`) REFERENCES `chem_analyses`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `norm_chem_analyses` ADD CONSTRAINT `norm_chem_analyses_norm_id_foreign` FOREIGN KEY (`norm_id`) REFERENCES `norms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `norms` ADD CONSTRAINT `norms_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `notification_group_email_addresses` ADD CONSTRAINT `notification_group_email_addresses_notification_group_id_foreign` FOREIGN KEY (`notification_group_id`) REFERENCES `notification_groups`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `notification_group_notification_types` ADD CONSTRAINT `notification_group_notification_types_fk` FOREIGN KEY (`notification_group_id`) REFERENCES `notification_groups`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `notification_group_users` ADD CONSTRAINT `notification_group_users_notification_group_id_foreign` FOREIGN KEY (`notification_group_id`) REFERENCES `notification_groups`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `notification_group_users` ADD CONSTRAINT `notification_group_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos` ADD CONSTRAINT `offer_pos_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos` ADD CONSTRAINT `offer_pos_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos` ADD CONSTRAINT `offer_pos_offer_id_foreign` FOREIGN KEY (`offer_id`) REFERENCES `offers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos` ADD CONSTRAINT `offer_pos_offer_pos_id_copy_from_foreign` FOREIGN KEY (`offer_pos_id_copy_from`) REFERENCES `offer_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos` ADD CONSTRAINT `offer_pos_tool_id_2_foreign` FOREIGN KEY (`tool_id_2`) REFERENCES `tools`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos` ADD CONSTRAINT `offer_pos_tool_id_3_foreign` FOREIGN KEY (`tool_id_3`) REFERENCES `tools`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos` ADD CONSTRAINT `offer_pos_tool_id_foreign` FOREIGN KEY (`tool_id`) REFERENCES `tools`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_available_batches` ADD CONSTRAINT `offer_pos_available_batches_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_available_batches` ADD CONSTRAINT `offer_pos_available_batches_offer_pos_id_foreign` FOREIGN KEY (`offer_pos_id`) REFERENCES `offer_pos`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_costs` ADD CONSTRAINT `offer_pos_costs_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_costs` ADD CONSTRAINT `offer_pos_costs_offer_pos_id_foreign` FOREIGN KEY (`offer_pos_id`) REFERENCES `offer_pos`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_costs` ADD CONSTRAINT `offer_pos_costs_operation_plan_pos_id_foreign` FOREIGN KEY (`operation_plan_pos_id`) REFERENCES `operation_plan_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_dimension_shaft_upset_parts` ADD CONSTRAINT `offer_pos_raw_dimension_id_foreign` FOREIGN KEY (`offer_pos_raw_dimension_id`) REFERENCES `offer_pos_raw_dimensions`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_dimension_upset_part_forged_beams` ADD CONSTRAINT `offer_pos_raw_dimension_id_forged_beams_foreign` FOREIGN KEY (`offer_pos_raw_dimension_id`) REFERENCES `offer_pos_raw_dimensions`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_mechanical_processes` ADD CONSTRAINT `offer_pos_mechanical_processes_offer_pos_id_foreign` FOREIGN KEY (`offer_pos_id`) REFERENCES `offer_pos`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_prod_order_pos` ADD CONSTRAINT `offer_pos_prod_order_pos_offer_pos_id_foreign` FOREIGN KEY (`offer_pos_id`) REFERENCES `offer_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_prod_order_pos` ADD CONSTRAINT `offer_pos_prod_order_pos_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_raw_dimensions` ADD CONSTRAINT `offer_pos_raw_dimensions_machine_id_2_foreign` FOREIGN KEY (`machine_id_2`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_raw_dimensions` ADD CONSTRAINT `offer_pos_raw_dimensions_machine_id_3_foreign` FOREIGN KEY (`machine_id_3`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_raw_dimensions` ADD CONSTRAINT `offer_pos_raw_dimensions_machine_id_4_foreign` FOREIGN KEY (`machine_id_4`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_raw_dimensions` ADD CONSTRAINT `offer_pos_raw_dimensions_machine_id_5_foreign` FOREIGN KEY (`machine_id_5`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_raw_dimensions` ADD CONSTRAINT `offer_pos_raw_dimensions_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offer_pos_raw_dimensions` ADD CONSTRAINT `offer_pos_raw_dimensions_offer_pos_id_foreign` FOREIGN KEY (`offer_pos_id`) REFERENCES `offer_pos`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offers` ADD CONSTRAINT `offers_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offers` ADD CONSTRAINT `offers_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offers` ADD CONSTRAINT `offers_delivery_term_id_foreign` FOREIGN KEY (`delivery_term_id`) REFERENCES `delivery_terms`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offers` ADD CONSTRAINT `offers_sales_area_id_foreign` FOREIGN KEY (`sales_area_id`) REFERENCES `sales_areas`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offers` ADD CONSTRAINT `offers_sales_group_id_foreign` FOREIGN KEY (`sales_group_id`) REFERENCES `sales_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offers` ADD CONSTRAINT `offers_sales_opportunity_id_foreign` FOREIGN KEY (`sales_opportunity_id`) REFERENCES `sales_opportunities`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `offers` ADD CONSTRAINT `offers_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `only_office_sessions` ADD CONSTRAINT `only_office_sessions_user_id_creator_foreign` FOREIGN KEY (`user_id_creator`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `operation_plan_pos` ADD CONSTRAINT `operation_plan_pos_machine_group_id_foreign` FOREIGN KEY (`machine_group_id`) REFERENCES `machine_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `operation_plan_pos` ADD CONSTRAINT `operation_plan_pos_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `operation_plan_pos` ADD CONSTRAINT `operation_plan_pos_operation_plan_id_foreign` FOREIGN KEY (`operation_plan_id`) REFERENCES `operation_plans`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `operation_plan_pos_heat_treatments` ADD CONSTRAINT `operation_plan_pos_heat_treatments_operation_plan_pos_id_foreign` FOREIGN KEY (`operation_plan_pos_id`) REFERENCES `operation_plan_pos`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `operation_plans` ADD CONSTRAINT `operation_plans_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `packaging_instruction_pos` ADD CONSTRAINT `packaging_instruction_pos_packaging_instruction_id_foreign` FOREIGN KEY (`packaging_instruction_id`) REFERENCES `packaging_instructions`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `packaging_instruction_pos` ADD CONSTRAINT `packaging_instruction_pos_unit_of_measure_id_foreign` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `unit_of_measures`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `plan_visu_color_scheme_sortings` ADD CONSTRAINT `fk_plan_visu_color_scheme_id_value` FOREIGN KEY (`plan_visu_color_scheme_id`) REFERENCES `plan_visu_color_schemes`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `plants` ADD CONSTRAINT `plants_item_id_packaging_rework_foreign` FOREIGN KEY (`item_id_packaging_rework`) REFERENCES `items`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `plants` ADD CONSTRAINT `plants_item_id_packaging_scrap_foreign` FOREIGN KEY (`item_id_packaging_scrap`) REFERENCES `items`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `plants` ADD CONSTRAINT `plants_item_state_id_default_foreign` FOREIGN KEY (`item_state_id_default`) REFERENCES `item_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `plants` ADD CONSTRAINT `plants_prod_order_pos_operation_id_indirect_foreign` FOREIGN KEY (`prod_order_pos_operation_id_indirect`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `plants` ADD CONSTRAINT `plants_storage_location_id_rework_foreign` FOREIGN KEY (`storage_location_id_rework`) REFERENCES `storage_locations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `plants` ADD CONSTRAINT `plants_storage_location_id_scrap_foreign` FOREIGN KEY (`storage_location_id_scrap`) REFERENCES `storage_locations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_inspection_operation_resources` ADD CONSTRAINT `pior_pio_foreign` FOREIGN KEY (`prod_inspection_operation_id`) REFERENCES `prod_inspection_operations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_inspection_operation_resources` ADD CONSTRAINT `prod_inspection_operation_resources_equipment_id_foreign` FOREIGN KEY (`equipment_id`) REFERENCES `equipment`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_inspection_operations` ADD CONSTRAINT `prod_inspection_operations_capacity_id_last_point_foreign` FOREIGN KEY (`capacity_id_last_point`) REFERENCES `capacities`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_inspection_operations` ADD CONSTRAINT `prod_inspection_operations_inspection_plan_id_foreign` FOREIGN KEY (`inspection_plan_id`) REFERENCES `inspection_plans`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_inspection_operations` ADD CONSTRAINT `prod_inspection_operations_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_lots` ADD CONSTRAINT `prod_lots_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos` ADD CONSTRAINT `prod_order_pos_calculation_id_foreign` FOREIGN KEY (`calculation_id`) REFERENCES `calculations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos` ADD CONSTRAINT `prod_order_pos_equipment_id_foreign` FOREIGN KEY (`equipment_id`) REFERENCES `equipment`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos` ADD CONSTRAINT `prod_order_pos_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos` ADD CONSTRAINT `prod_order_pos_prod_order_id_foreign` FOREIGN KEY (`prod_order_id`) REFERENCES `prod_orders`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos` ADD CONSTRAINT `prod_order_pos_sales_order_pos_id_foreign` FOREIGN KEY (`sales_order_pos_id`) REFERENCES `sales_order_pos`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos` ADD CONSTRAINT `prod_order_pos_storage_location_id_foreign` FOREIGN KEY (`storage_location_id`) REFERENCES `storage_locations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos` ADD CONSTRAINT `prod_order_pos_storage_location_id_rework_foreign` FOREIGN KEY (`storage_location_id_rework`) REFERENCES `storage_locations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos` ADD CONSTRAINT `prod_order_pos_storage_location_id_scrap_foreign` FOREIGN KEY (`storage_location_id_scrap`) REFERENCES `storage_locations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos` ADD CONSTRAINT `prod_order_pos_supplier_id_tool_foreign` FOREIGN KEY (`supplier_id_tool`) REFERENCES `suppliers`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos` ADD CONSTRAINT `prod_order_pos_unit_of_measure_id_foreign` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `unit_of_measures`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos` ADD CONSTRAINT `prod_order_pos_user_id_creator_foreign` FOREIGN KEY (`user_id_creator`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos` ADD CONSTRAINT `prod_order_pos_user_id_responsible_foreign` FOREIGN KEY (`user_id_responsible`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_bom_pos` ADD CONSTRAINT `prod_order_pos_bom_pos_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_bom_pos` ADD CONSTRAINT `prod_order_pos_bom_pos_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_bom_pos` ADD CONSTRAINT `prod_order_pos_bom_pos_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_bom_pos` ADD CONSTRAINT `prod_order_pos_bom_pos_storage_bin_id_foreign` FOREIGN KEY (`storage_bin_id`) REFERENCES `storage_bins`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_bom_pos` ADD CONSTRAINT `prod_order_pos_bom_pos_storage_location_id_foreign` FOREIGN KEY (`storage_location_id`) REFERENCES `storage_locations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_bom_pos` ADD CONSTRAINT `prod_order_pos_bom_pos_unit_of_measure_id_foreign` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `unit_of_measures`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_bom_pos` ADD CONSTRAINT `prod_order_pos_bom_pos_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_alt_machines` ADD CONSTRAINT `prod_order_pos_operation_alt_machines_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_alt_machines` ADD CONSTRAINT `prod_order_pos_operation_alt_machines_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_batches` ADD CONSTRAINT `prod_order_pos_operation_batches_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_batches` ADD CONSTRAINT `prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_confirmations` ADD CONSTRAINT `prod_order_pos_operation_confirmations_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_consumptions` ADD CONSTRAINT `popoq_id_foreign_for_popo_consumptions` FOREIGN KEY (`prod_order_pos_operation_quantity_id`) REFERENCES `prod_order_pos_operation_quantities`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_consumptions` ADD CONSTRAINT `prod_order_consumptions_psa_id_foreign` FOREIGN KEY (`production_supply_area_id`) REFERENCES `production_supply_areas`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_consumptions` ADD CONSTRAINT `prod_order_consumptions_storage_location_id_foreign` FOREIGN KEY (`storage_location_id`) REFERENCES `storage_locations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_consumptions` ADD CONSTRAINT `prod_order_pos_operation_consumptions_handling_unit_id_foreign` FOREIGN KEY (`handling_unit_id`) REFERENCES `handling_units`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_consumptions` ADD CONSTRAINT `prod_order_pos_operation_consumptions_item_plant_id_foreign` FOREIGN KEY (`item_plant_id`) REFERENCES `item_plants`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_consumptions` ADD CONSTRAINT `prod_order_pos_operation_consumptions_item_state_id_foreign` FOREIGN KEY (`item_state_id`) REFERENCES `item_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_consumptions` ADD CONSTRAINT `prod_order_pos_operation_consumptions_p_o_p_o_c_id_foreign` FOREIGN KEY (`prod_order_pos_operation_confirmation_id`) REFERENCES `prod_order_pos_operation_confirmations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_consumptions` ADD CONSTRAINT `prod_order_pos_operation_consumptions_storage_bin_id_foreign` FOREIGN KEY (`storage_bin_id`) REFERENCES `storage_bins`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_consumptions` ADD CONSTRAINT `prod_order_pos_operation_consumptions_unit_of_measure_id_foreign` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `unit_of_measures`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_consumptions` ADD CONSTRAINT `prod_order_pos_operation_consumptions_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_consumptions` ADD CONSTRAINT `prod_order_pos_operation_id_foreign_for_popo_consumptions` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_deliveries` ADD CONSTRAINT `prod_order_pos_operation_deliveries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_deliveries` ADD CONSTRAINT `prod_order_pos_operation_id_foreign_for_operation_deliveries` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_handling_units` ADD CONSTRAINT `prod_order_pos_operation_handling_units_handling_unit_id_foreign` FOREIGN KEY (`handling_unit_id`) REFERENCES `handling_units`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_handling_units` ADD CONSTRAINT `prod_order_pos_operation_handling_units_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_handling_units` ADD CONSTRAINT `prod_order_pos_operation_id_foreign_for_operation_handling_units` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_loaded_quantities` ADD CONSTRAINT `loaded_quantities_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_loaded_quantities` ADD CONSTRAINT `loaded_quantities_prod_order_pos_op_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_loaded_quantities` ADD CONSTRAINT `loaded_quantities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_quantities` ADD CONSTRAINT `prod_order_pos_operation_id_foreign_for_operation_quantities` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_quantities` ADD CONSTRAINT `prod_order_pos_operation_quantities_canceled_foreign` FOREIGN KEY (`prod_order_pos_operation_quantity_id_canceled`) REFERENCES `prod_order_pos_operation_quantities`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_quantities` ADD CONSTRAINT `prod_order_pos_operation_quantities_item_state_id_foreign` FOREIGN KEY (`item_state_id`) REFERENCES `item_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_quantities` ADD CONSTRAINT `prod_order_pos_operation_quantities_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_quantities` ADD CONSTRAINT `prod_order_pos_operation_quantities_p_o_p_o_c_id_foreign` FOREIGN KEY (`prod_order_pos_operation_confirmation_id`) REFERENCES `prod_order_pos_operation_confirmations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_quantities` ADD CONSTRAINT `prod_order_pos_operation_quantities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_resource_times` ADD CONSTRAINT `fk_eq_parent` FOREIGN KEY (`equipment_id_parent`) REFERENCES `equipment`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_resource_times` ADD CONSTRAINT `fk_pos_op_id` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_resource_times` ADD CONSTRAINT `prod_order_pos_operation_resource_times_equipment_id_foreign` FOREIGN KEY (`equipment_id`) REFERENCES `equipment`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_resources` ADD CONSTRAINT `prod_order_pos_operation_resources_equipment_id_foreign` FOREIGN KEY (`equipment_id`) REFERENCES `equipment`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_resources` ADD CONSTRAINT `prod_order_pos_operation_resources_item_id_tool_foreign` FOREIGN KEY (`item_id_tool`) REFERENCES `items`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_resources` ADD CONSTRAINT `prod_order_pos_operation_resources_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_unloaded_quantities` ADD CONSTRAINT `unloaded_quantities_loaded_quantity_foreign` FOREIGN KEY (`prod_order_pos_operation_loaded_quantity_id`) REFERENCES `prod_order_pos_operation_loaded_quantities`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_unloaded_quantities` ADD CONSTRAINT `unloaded_quantities_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_unloaded_quantities` ADD CONSTRAINT `unloaded_quantities_prod_order_pos_op_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operation_unloaded_quantities` ADD CONSTRAINT `unloaded_quantities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_op_plan_pos_erp_machine_id_foreign` FOREIGN KEY (`erp_machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_op_plan_pos_machine_group_id_foreign` FOREIGN KEY (`machine_group_id`) REFERENCES `machine_groups`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_op_plan_pos_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_op_plan_pos_plan_machine_id_foreign` FOREIGN KEY (`plan_machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_op_plan_pos_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_op_plan_pos_tool_id_foreign` FOREIGN KEY (`tool_id`) REFERENCES `tools`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_operations_item_id_tool_foreign` FOREIGN KEY (`item_id_tool`) REFERENCES `items`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_operations_item_id_tool_insert_foreign` FOREIGN KEY (`item_id_tool_insert`) REFERENCES `items`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_operations_operation_control_profile_id_foreign` FOREIGN KEY (`operation_control_profile_id`) REFERENCES `operation_control_profiles`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_operations_operation_plan_id_origin_foreign` FOREIGN KEY (`operation_plan_id_origin`) REFERENCES `operation_plans`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_operations_operation_plan_pos_id_origin_foreign` FOREIGN KEY (`operation_plan_pos_id_origin`) REFERENCES `operation_plan_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_operations_plant_id_production_foreign` FOREIGN KEY (`plant_id_production`) REFERENCES `plants`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_operations_prod_lot_id_foreign` FOREIGN KEY (`prod_lot_id`) REFERENCES `prod_lots`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_operations_resource_group_id_erp_foreign` FOREIGN KEY (`resource_group_id_erp`) REFERENCES `resource_groups`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_operations_resource_group_id_foreign` FOREIGN KEY (`resource_group_id`) REFERENCES `resource_groups`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_operations_resource_group_id_plan_foreign` FOREIGN KEY (`resource_group_id_plan`) REFERENCES `resource_groups`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_operations_tool_insert_id_foreign` FOREIGN KEY (`tool_insert_id`) REFERENCES `tools`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_operations_unit_of_measure_id_foreign` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `unit_of_measures`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_operations_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_operations` ADD CONSTRAINT `prod_order_pos_operations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_order_pos_serials` ADD CONSTRAINT `prod_order_pos_serials_prod_order_pos_id_foreign` FOREIGN KEY (`prod_order_pos_id`) REFERENCES `prod_order_pos`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_orders` ADD CONSTRAINT `prod_orders_call_off_id_foreign` FOREIGN KEY (`call_off_id`) REFERENCES `call_offs`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_orders` ADD CONSTRAINT `prod_orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_orders` ADD CONSTRAINT `prod_orders_maintenance_type_id_foreign` FOREIGN KEY (`maintenance_type_id`) REFERENCES `maintenance_types`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_orders` ADD CONSTRAINT `prod_orders_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plants`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_orders` ADD CONSTRAINT `prod_orders_plant_id_production_foreign` FOREIGN KEY (`plant_id_production`) REFERENCES `plants`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `prod_orders` ADD CONSTRAINT `prod_orders_prod_order_type_id_foreign` FOREIGN KEY (`prod_order_type_id`) REFERENCES `prod_order_types`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `production_supply_areas` ADD CONSTRAINT `production_supply_areas_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plants`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `project_phases` ADD CONSTRAINT `project_phases_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `project_phases`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `project_phases` ADD CONSTRAINT `project_phases_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `project_phases` ADD CONSTRAINT `project_phases_task_priority_id_foreign` FOREIGN KEY (`task_priority_id`) REFERENCES `task_priorities`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `project_phases` ADD CONSTRAINT `project_phases_user_id_creator_foreign` FOREIGN KEY (`user_id_creator`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `project_phases` ADD CONSTRAINT `project_phases_user_id_responsible_foreign` FOREIGN KEY (`user_id_responsible`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `project_phases` ADD CONSTRAINT `project_phases_user_id_updated_by_foreign` FOREIGN KEY (`user_id_updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `project_steering_committee` ADD CONSTRAINT `project_steering_committee_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `project_steering_committee` ADD CONSTRAINT `project_steering_committee_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `project_team_member` ADD CONSTRAINT `project_team_member_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `project_team_member` ADD CONSTRAINT `project_team_member_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `projects` ADD CONSTRAINT `projects_user_id_creator_foreign` FOREIGN KEY (`user_id_creator`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `projects` ADD CONSTRAINT `projects_user_id_leader_foreign` FOREIGN KEY (`user_id_leader`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `projects` ADD CONSTRAINT `projects_user_id_updated_by_foreign` FOREIGN KEY (`user_id_updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `quali_events` ADD CONSTRAINT `quali_events_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `quali_events` ADD CONSTRAINT `quali_events_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `qualification_users` ADD CONSTRAINT `qualification_users_qualification_id_foreign` FOREIGN KEY (`qualification_id`) REFERENCES `qualifications`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `qualification_users` ADD CONSTRAINT `qualification_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `qualifications` ADD CONSTRAINT `qualifications_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `qualifications` ADD CONSTRAINT `qualifications_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `raw_dimension_types` ADD CONSTRAINT `raw_dimension_types_offer_pos_raw_dimensions_id_foreign` FOREIGN KEY (`offer_pos_raw_dimensions_id`) REFERENCES `offer_pos_raw_dimensions`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `releasable_users` ADD CONSTRAINT `releasable_users_user_id_releaser_foreign` FOREIGN KEY (`user_id_releaser`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report_color_thresholds` ADD CONSTRAINT `report_color_thresholds_hall_id_foreign` FOREIGN KEY (`hall_id`) REFERENCES `halls`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report_users` ADD CONSTRAINT `report_users_report_id_foreign` FOREIGN KEY (`report_id`) REFERENCES `reports`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report_users` ADD CONSTRAINT `report_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `reports` ADD CONSTRAINT `reports_report_category_id_foreign` FOREIGN KEY (`report_category_id`) REFERENCES `report_categories`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `resource_groups` ADD CONSTRAINT `resource_groups_hall_id_foreign` FOREIGN KEY (`hall_id`) REFERENCES `halls`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `responsibles` ADD CONSTRAINT `responsibles_user_id_responsible_foreign` FOREIGN KEY (`user_id_responsible`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `role_has_permissions` ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `role_has_permissions` ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sales_opportunities` ADD CONSTRAINT `sales_opportunities_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sales_opportunities` ADD CONSTRAINT `sales_opportunities_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sales_opportunities` ADD CONSTRAINT `sales_opportunities_delivery_term_id_foreign` FOREIGN KEY (`delivery_term_id`) REFERENCES `delivery_terms`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sales_opportunities` ADD CONSTRAINT `sales_opportunities_sales_area_id_foreign` FOREIGN KEY (`sales_area_id`) REFERENCES `sales_areas`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sales_opportunities` ADD CONSTRAINT `sales_opportunities_sales_group_id_foreign` FOREIGN KEY (`sales_group_id`) REFERENCES `sales_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sales_order_pos` ADD CONSTRAINT `sales_order_pos_sales_order_id_foreign` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sales_orders` ADD CONSTRAINT `sales_orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sales_statuses` ADD CONSTRAINT `sales_statuses_sales_status_group_id_foreign` FOREIGN KEY (`sales_status_group_id`) REFERENCES `sales_status_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sequence_operations` ADD CONSTRAINT `sequence_operations_specification_id_foreign` FOREIGN KEY (`specification_id`) REFERENCES `specifications`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shif_visu_overview_measure_type_submissions` ADD CONSTRAINT `fk_measure_overview_detail` FOREIGN KEY (`overview_details_id`) REFERENCES `shift_visu_overview_details`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shift_model_shifts` ADD CONSTRAINT `shift_model_shifts_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shift_model_shifts` ADD CONSTRAINT `shift_model_shifts_shift_model_id_foreign` FOREIGN KEY (`shift_model_id`) REFERENCES `shift_models`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shift_visu_component_options` ADD CONSTRAINT `shift_visu_component_options_shift_visu_component_id_foreign` FOREIGN KEY (`shift_visu_component_id`) REFERENCES `shift_visu_components`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shift_visu_hall_permissions` ADD CONSTRAINT `shift_visu_hall_permissions_hall_id_foreign` FOREIGN KEY (`hall_id`) REFERENCES `halls`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shift_visu_hall_permissions` ADD CONSTRAINT `shift_visu_hall_permissions_shift_visu_issue_type_id_foreign` FOREIGN KEY (`shift_visu_issue_type_id`) REFERENCES `shift_visu_issue_types`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shift_visu_issue_type_shift_visu_measure_components` ADD CONSTRAINT `fk_measure_component` FOREIGN KEY (`measure_component_id`) REFERENCES `measure_components`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shift_visu_issue_type_shift_visu_measure_components` ADD CONSTRAINT `svit_svmc_fk` FOREIGN KEY (`shift_visu_issue_type_id`) REFERENCES `shift_visu_issue_types`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shift_visu_overview_component_options` ADD CONSTRAINT `fk_overview_detail_id` FOREIGN KEY (`overview_details_id`) REFERENCES `shift_visu_overview_details`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shift_visu_overview_details` ADD CONSTRAINT `shift_visu_overview_details_chat_id_foreign` FOREIGN KEY (`chat_id`) REFERENCES `chats`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shift_visu_overview_details` ADD CONSTRAINT `shift_visu_overview_details_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shift_visu_overview_details` ADD CONSTRAINT `shift_visu_overview_details_error_id_foreign` FOREIGN KEY (`error_id`) REFERENCES `shift_visu_issue_types`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shift_visu_overview_details` ADD CONSTRAINT `shift_visu_overview_details_hall_id_foreign` FOREIGN KEY (`hall_id`) REFERENCES `halls`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shift_visu_overview_details` ADD CONSTRAINT `shift_visu_overview_details_responsible_id_foreign` FOREIGN KEY (`responsible_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sim_call_offs` ADD CONSTRAINT `sim_call_offs_call_off_simulation_id_foreign` FOREIGN KEY (`call_off_simulation_id`) REFERENCES `call_off_simulations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sim_call_offs` ADD CONSTRAINT `sim_call_offs_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `specification_chem_analyses` ADD CONSTRAINT `specification_chem_analyses_chem_analysis_id_foreign` FOREIGN KEY (`chem_analysis_id`) REFERENCES `chem_analyses`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `specification_chem_analyses` ADD CONSTRAINT `specification_chem_analyses_specification_id_foreign` FOREIGN KEY (`specification_id`) REFERENCES `specifications`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `specifications` ADD CONSTRAINT `specifications_deformation_id_foreign` FOREIGN KEY (`deformation_id`) REFERENCES `deformations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `specifications` ADD CONSTRAINT `specifications_documentation_id_foreign` FOREIGN KEY (`documentation_id`) REFERENCES `documentations`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `specifications` ADD CONSTRAINT `specifications_hardenability_range_id_foreign` FOREIGN KEY (`hardenability_range_id`) REFERENCES `hardenability_ranges`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `specifications` ADD CONSTRAINT `specifications_hwe_work_plan_id_foreign` FOREIGN KEY (`hwe_work_plan_id`) REFERENCES `hwe_work_plans`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `specifications` ADD CONSTRAINT `specifications_material_analysis_id_foreign` FOREIGN KEY (`material_analysis_id`) REFERENCES `material_analyses`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `specifications` ADD CONSTRAINT `specifications_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `specifications` ADD CONSTRAINT `specifications_metallography_id_foreign` FOREIGN KEY (`metallography_id`) REFERENCES `metallographies`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `specifications` ADD CONSTRAINT `specifications_non_destructive_testing_id_foreign` FOREIGN KEY (`non_destructive_testing_id`) REFERENCES `non_destructive_testings`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `specifications` ADD CONSTRAINT `specifications_residual_material_id_foreign` FOREIGN KEY (`residual_material_id`) REFERENCES `residual_materials`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `specifications` ADD CONSTRAINT `specifications_testing_scope_id_foreign` FOREIGN KEY (`testing_scope_id`) REFERENCES `testing_scopes`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `standard_value_key_activity_types` ADD CONSTRAINT `standard_value_key_activity_types_standard_value_key_id_foreign` FOREIGN KEY (`standard_value_key_id`) REFERENCES `standard_value_keys`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `stock_operation_inputs` ADD CONSTRAINT `stock_operation_inputs_item_state_id_foreign` FOREIGN KEY (`item_state_id`) REFERENCES `item_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `stock_operation_inputs` ADD CONSTRAINT `stock_operation_inputs_stock_operation_id_foreign` FOREIGN KEY (`stock_operation_id`) REFERENCES `stock_operations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `stock_operation_outputs` ADD CONSTRAINT `stock_operation_outputs_item_state_id_foreign` FOREIGN KEY (`item_state_id`) REFERENCES `item_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `stock_operation_outputs` ADD CONSTRAINT `stock_operation_outputs_stock_operation_id_foreign` FOREIGN KEY (`stock_operation_id`) REFERENCES `stock_operations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `stock_operations` ADD CONSTRAINT `stock_operations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `stocks` ADD CONSTRAINT `stocks_item_state_id_foreign` FOREIGN KEY (`item_state_id`) REFERENCES `item_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `storage_bins` ADD CONSTRAINT `storage_bins_storage_type_id_foreign` FOREIGN KEY (`storage_type_id`) REFERENCES `storage_types`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `storage_locations` ADD CONSTRAINT `storage_locations_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plants`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `storage_locations` ADD CONSTRAINT `storage_locations_transport_order_type_id_foreign` FOREIGN KEY (`transport_order_type_id`) REFERENCES `transport_order_types`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `storage_locations` ADD CONSTRAINT `storage_locations_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sub_responsible_task` ADD CONSTRAINT `sub_responsible_task_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sub_responsible_task` ADD CONSTRAINT `sub_responsible_task_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `supplier_tasks` ADD CONSTRAINT `supplier_tasks_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `supplier_tasks` ADD CONSTRAINT `supplier_tasks_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tasks` ADD CONSTRAINT `tasks_action_setting_id_foreign` FOREIGN KEY (`action_setting_id`) REFERENCES `action_settings`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tasks` ADD CONSTRAINT `tasks_chat_id_foreign` FOREIGN KEY (`chat_id`) REFERENCES `chats`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tasks` ADD CONSTRAINT `tasks_meeting_id_foreign` FOREIGN KEY (`meeting_id`) REFERENCES `meetings`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tasks` ADD CONSTRAINT `tasks_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tasks` ADD CONSTRAINT `tasks_task_priority_id_foreign` FOREIGN KEY (`task_priority_id`) REFERENCES `task_priorities`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tasks` ADD CONSTRAINT `tasks_team_id_foreign` FOREIGN KEY (`team_id`) REFERENCES `teams`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tasks` ADD CONSTRAINT `tasks_user_id_creator_foreign` FOREIGN KEY (`user_id_creator`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tasks` ADD CONSTRAINT `tasks_user_id_responsible_foreign` FOREIGN KEY (`user_id_responsible`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tasks` ADD CONSTRAINT `tasks_user_id_updated_by_foreign` FOREIGN KEY (`user_id_updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `team_user` ADD CONSTRAINT `team_user_team_id_foreign` FOREIGN KEY (`team_id`) REFERENCES `teams`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `team_user` ADD CONSTRAINT `team_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `teams` ADD CONSTRAINT `teams_chat_id_foreign` FOREIGN KEY (`chat_id`) REFERENCES `chats`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `teams` ADD CONSTRAINT `teams_user_id_creator_foreign` FOREIGN KEY (`user_id_creator`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `teams` ADD CONSTRAINT `teams_user_id_updated_by_foreign` FOREIGN KEY (`user_id_updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `terminals` ADD CONSTRAINT `terminals_hall_id_foreign` FOREIGN KEY (`hall_id`) REFERENCES `halls`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `terminals` ADD CONSTRAINT `terminals_printer_id_foreign` FOREIGN KEY (`printer_id`) REFERENCES `printers`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `testing_scope_according_to_impact_tests` ADD CONSTRAINT `testing_scope_according_to_impact_tests_testing_scope_id_foreign` FOREIGN KEY (`testing_scope_id`) REFERENCES `testing_scopes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `testing_scope_according_to_tensile_tests` ADD CONSTRAINT `fk_ts_according_to_tensile_test_ts_id` FOREIGN KEY (`testing_scope_id`) REFERENCES `testing_scopes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `testing_scope_attestation_entities` ADD CONSTRAINT `testing_scope_attestation_entities_testing_scope_id_foreign` FOREIGN KEY (`testing_scope_id`) REFERENCES `testing_scopes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `testing_scope_classified_bies` ADD CONSTRAINT `testing_scope_classified_bies_testing_scope_id_foreign` FOREIGN KEY (`testing_scope_id`) REFERENCES `testing_scopes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `testing_scope_melting_types` ADD CONSTRAINT `testing_scope_melting_types_testing_scope_id_foreign` FOREIGN KEY (`testing_scope_id`) REFERENCES `testing_scopes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `testing_scope_sample_depths` ADD CONSTRAINT `testing_scope_sample_depths_testing_scope_id_foreign` FOREIGN KEY (`testing_scope_id`) REFERENCES `testing_scopes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tool_groups` ADD CONSTRAINT `tool_groups_hall_id_foreign` FOREIGN KEY (`hall_id`) REFERENCES `halls`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tool_status_histories` ADD CONSTRAINT `tool_status_histories_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tool_status_histories` ADD CONSTRAINT `tool_status_histories_prod_order_id_foreign` FOREIGN KEY (`prod_order_id`) REFERENCES `prod_orders`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tool_status_histories_backup` ADD CONSTRAINT `tool_status_histories_backup_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tool_status_histories_backup` ADD CONSTRAINT `tool_status_histories_backup_prod_order_id_foreign` FOREIGN KEY (`prod_order_id`) REFERENCES `prod_orders`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tool_tasks` ADD CONSTRAINT `tool_tasks_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tool_tasks` ADD CONSTRAINT `tool_tasks_tool_id_foreign` FOREIGN KEY (`tool_id`) REFERENCES `tools`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tool_tool_groups` ADD CONSTRAINT `tool_tool_groups_tool_group_id_foreign` FOREIGN KEY (`tool_group_id`) REFERENCES `tool_groups`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tool_tool_groups` ADD CONSTRAINT `tool_tool_groups_tool_id_foreign` FOREIGN KEY (`tool_id`) REFERENCES `tools`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tpm_groups` ADD CONSTRAINT `tpm_groups_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plants`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tpm_sub_groups` ADD CONSTRAINT `tpm_sub_groups_tpm_group_id_foreign` FOREIGN KEY (`tpm_group_id`) REFERENCES `tpm_groups`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `training_trainees` ADD CONSTRAINT `training_trainees_training_id_foreign` FOREIGN KEY (`training_id`) REFERENCES `trainings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `training_trainees` ADD CONSTRAINT `training_trainees_user_id_trainee_foreign` FOREIGN KEY (`user_id_trainee`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `training_user_groups` ADD CONSTRAINT `training_user_groups_training_id_foreign` FOREIGN KEY (`training_id`) REFERENCES `trainings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `training_user_groups` ADD CONSTRAINT `training_user_groups_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `training_workspaces` ADD CONSTRAINT `training_workspaces_training_id_foreign` FOREIGN KEY (`training_id`) REFERENCES `trainings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `trainings` ADD CONSTRAINT `trainings_user_id_trainer_foreign` FOREIGN KEY (`user_id_trainer`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `transport_order_pos` ADD CONSTRAINT `transport_order_pos_item_state_id_foreign` FOREIGN KEY (`item_state_id`) REFERENCES `item_states`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `transport_order_pos` ADD CONSTRAINT `transport_order_pos_prod_order_pos_bom_pos_id_foreign` FOREIGN KEY (`prod_order_pos_bom_pos_id`) REFERENCES `prod_order_pos_bom_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `transport_order_pos` ADD CONSTRAINT `transport_order_pos_responsible_user_id_foreign` FOREIGN KEY (`responsible_user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `transport_order_pos` ADD CONSTRAINT `transport_order_pos_transport_order_id_foreign` FOREIGN KEY (`transport_order_id`) REFERENCES `transport_orders`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `transport_order_pos` ADD CONSTRAINT `transport_order_pos_transport_order_type_id_foreign` FOREIGN KEY (`transport_order_type_id`) REFERENCES `transport_order_types`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `transport_order_pos` ADD CONSTRAINT `transport_order_pos_user_id_cancelled_by_foreign` FOREIGN KEY (`user_id_cancelled_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `transport_order_pos_deliveries` ADD CONSTRAINT `transport_order_pos_deliveries_transport_order_pos_id_foreign` FOREIGN KEY (`transport_order_pos_id`) REFERENCES `transport_order_pos`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `transport_order_pos_deliveries` ADD CONSTRAINT `transport_order_pos_deliveries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `us_norm_adjustments` ADD CONSTRAINT `us_norm_adjustments_us_norm_id_foreign` FOREIGN KEY (`us_norm_id`) REFERENCES `us_norms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `us_norm_rating_justifications` ADD CONSTRAINT `us_norm_rating_justifications_us_norm_rating_id_foreign` FOREIGN KEY (`us_norm_rating_id`) REFERENCES `us_norm_ratings`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `us_norm_ratings` ADD CONSTRAINT `us_norm_ratings_us_norm_id_foreign` FOREIGN KEY (`us_norm_id`) REFERENCES `us_norms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `us_norm_test_scopes` ADD CONSTRAINT `us_norm_test_scopes_us_norm_id_foreign` FOREIGN KEY (`us_norm_id`) REFERENCES `us_norms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `us_norm_test_sections` ADD CONSTRAINT `us_norm_test_sections_us_norm_id_foreign` FOREIGN KEY (`us_norm_id`) REFERENCES `us_norms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_groups` ADD CONSTRAINT `user_groups_hall_id_foreign` FOREIGN KEY (`hall_id`) REFERENCES `halls`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_position_times` ADD CONSTRAINT `user_position_times_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plants`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_position_times` ADD CONSTRAINT `user_position_times_shift_model_id_foreign` FOREIGN KEY (`shift_model_id`) REFERENCES `shift_models`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_position_times` ADD CONSTRAINT `user_position_times_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_registered_times` ADD CONSTRAINT `user_registered_times_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_registered_times` ADD CONSTRAINT `user_registered_times_machine_state_id_foreign` FOREIGN KEY (`machine_state_id`) REFERENCES `machine_states`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_registered_times` ADD CONSTRAINT `user_registered_times_prod_order_pos_operation_id_foreign` FOREIGN KEY (`prod_order_pos_operation_id`) REFERENCES `prod_order_pos_operations`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_registered_times` ADD CONSTRAINT `user_registered_times_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_registered_times` ADD CONSTRAINT `user_registered_times_svk_activity_type_id_foreign` FOREIGN KEY (`standard_value_key_activity_type_id`) REFERENCES `standard_value_key_activity_types`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_registered_times` ADD CONSTRAINT `user_registered_times_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_user_groups` ADD CONSTRAINT `user_user_groups_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_user_groups` ADD CONSTRAINT `user_user_groups_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `fk_supervisor1` FOREIGN KEY (`supervisor1_user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `fk_supervisor2` FOREIGN KEY (`supervisor2_user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `users_hall_id_foreign` FOREIGN KEY (`hall_id`) REFERENCES `halls`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `users_shift_model_id_foreign` FOREIGN KEY (`shift_model_id`) REFERENCES `shift_models`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `vt_norm_auxiliary_means` ADD CONSTRAINT `vt_norm_auxiliary_means_vt_norm_id_foreign` FOREIGN KEY (`vt_norm_id`) REFERENCES `vt_norms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `vt_norm_test_techniques` ADD CONSTRAINT `vt_norm_test_techniques_vt_norm_id_foreign` FOREIGN KEY (`vt_norm_id`) REFERENCES `vt_norms`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `workload_settings` ADD CONSTRAINT `workload_settings_hall_id_foreign` FOREIGN KEY (`hall_id`) REFERENCES `halls`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

