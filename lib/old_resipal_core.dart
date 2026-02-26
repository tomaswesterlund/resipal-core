library resipal_core;

// DATA
export 'src/data/resipal_supabase.dart';
export 'src/data/sources/access_log_data_source.dart';
export 'src/data/sources/application_data_source.dart';
export 'src/data/sources/community_data_source.dart';
export 'src/data/sources/contract_data_source.dart';
export 'src/data/sources/error_log_data_source.dart';
export 'src/data/sources/invitation_data_source.dart';
export 'src/data/sources/maintenance_fee_data_source.dart';
export 'src/data/sources/membership_data_source.dart';
export 'src/data/sources/movement_data_source.dart';
export 'src/data/sources/payment_data_source.dart';
export 'src/data/sources/property_data_source.dart';
export 'src/data/sources/user_data_source.dart';
export 'src/data/sources/visitor_data_source.dart';


// Entities
export 'src/domain/entities/community/community_directory_entity.dart';
export 'src/domain/entities/community/community_entity.dart';
export 'src/domain/entities/payment/payment_entity.dart';
export 'src/domain/entities/payment/payment_ledger_entity.dart';
export 'src/domain/entities/contract_entity.dart';
export 'src/domain/entities/id_entity.dart';
export 'src/domain/entities/invitation_entity.dart';
export 'src/domain/entities/membership_entity.dart';
export 'src/domain/entities/property_entity.dart';
export 'src/domain/entities/resident_entity.dart';
export 'src/domain/entities/user_entity.dart';
export 'src/domain/entities/visitor_entity.dart';


// Use Cases
export 'src/domain/use_cases/communities/watch_community_by_id.dart';

export 'src/domain/use_cases/contracts/create_contract.dart';
export 'src/domain/use_cases/contracts/fetch_contract.dart';
export 'src/domain/use_cases/contracts/get_contract_ref.dart';
export 'src/domain/use_cases/contracts/get_contract.dart';
export 'src/domain/use_cases/contracts/get_contracts_by_community.dart';
export 'src/domain/use_cases/contracts/watch_contracts_by_community.dart';

export 'src/domain/use_cases/properties/fetch_property_by_id.dart';
export 'src/domain/use_cases/properties/get_properties.dart';
export 'src/domain/use_cases/properties/get_property_by_id.dart';
export 'src/domain/use_cases/properties/register_property.dart';
export 'src/domain/use_cases/properties/watch_properties_by_community.dart';
export 'src/domain/use_cases/properties/watch_property_by_id.dart';


export 'src/domain/use_cases/residents/get_resident.dart';
export 'src/domain/use_cases/residents/get_residents_by_community.dart';



// Shared Presentation/UI
export 'src/presentation/shared/texts/header_text.dart';
export 'src/presentation/shared/views/loading_view.dart';
export 'src/presentation/shared/views/error_view.dart';

// Services
export 'src/services/auth_service.dart';
export 'src/services/image_service.dart';
export 'src/services/logger_service.dart';
export 'src/services/service_locator.dart';

// HELPERS
export 'src/helpers/formatters/currency_formatter.dart';
export 'src/helpers/formatters/date_formatters.dart';
export 'src/helpers/formatters/id_formatter.dart';
export 'src/helpers/nullable_string_extensions.dart';