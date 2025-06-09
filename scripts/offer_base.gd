extends Resource
class_name OfferBase

@export var sender: String
@export var intro: String
@export_multiline var details: String
@export_enum("Salmon", "Tuna", "Cod", "Trout", "Snapper", "Catfish", "Carp", "Herring", "Pike") var requirement: String
@export var required_quality: int
@export var required_size: int
@export var required_expiration: int
@export var required_alive: bool
@export var exp_requirement: int
@export var rarity: float = 1.0
@export var has_requirements: bool = true
@export var money_reward: float
@export var exp_reward: int
@export var repeatable: bool = false
