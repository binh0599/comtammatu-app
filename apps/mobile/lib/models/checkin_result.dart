class Branch {
  final int id;
  final String name;
  final String address;

  const Branch({
    required this.id,
    required this.name,
    required this.address,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }

  Branch copyWith({
    int? id,
    String? name,
    String? address,
  }) {
    return Branch(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Branch && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Branch(id: $id, name: $name)';
}

class CheckinStreak {
  final int current;
  final int bonus;
  final int nextMilestone;
  final int nextMilestoneBonus;

  const CheckinStreak({
    required this.current,
    required this.bonus,
    required this.nextMilestone,
    required this.nextMilestoneBonus,
  });

  factory CheckinStreak.fromJson(Map<String, dynamic> json) {
    return CheckinStreak(
      current: json['current'] as int,
      bonus: json['bonus'] as int,
      nextMilestone: json['next_milestone'] as int,
      nextMilestoneBonus: json['next_milestone_bonus'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current': current,
      'bonus': bonus,
      'next_milestone': nextMilestone,
      'next_milestone_bonus': nextMilestoneBonus,
    };
  }

  CheckinStreak copyWith({
    int? current,
    int? bonus,
    int? nextMilestone,
    int? nextMilestoneBonus,
  }) {
    return CheckinStreak(
      current: current ?? this.current,
      bonus: bonus ?? this.bonus,
      nextMilestone: nextMilestone ?? this.nextMilestone,
      nextMilestoneBonus: nextMilestoneBonus ?? this.nextMilestoneBonus,
    );
  }

  @override
  String toString() =>
      'CheckinStreak(current: $current, bonus: $bonus, nextMilestone: $nextMilestone)';
}

class CheckinResult {
  final int checkinId;
  final Branch branch;
  final double pointsEarned;
  final double newBalance;
  final CheckinStreak streak;
  final DateTime checkedInAt;

  const CheckinResult({
    required this.checkinId,
    required this.branch,
    required this.pointsEarned,
    required this.newBalance,
    required this.streak,
    required this.checkedInAt,
  });

  factory CheckinResult.fromJson(Map<String, dynamic> json) {
    return CheckinResult(
      checkinId: json['checkin_id'] as int,
      branch: Branch.fromJson(json['branch'] as Map<String, dynamic>),
      pointsEarned: (json['points_earned'] as num).toDouble(),
      newBalance: (json['new_balance'] as num).toDouble(),
      streak:
          CheckinStreak.fromJson(json['streak'] as Map<String, dynamic>),
      checkedInAt: DateTime.parse(json['checked_in_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checkin_id': checkinId,
      'branch': branch.toJson(),
      'points_earned': pointsEarned,
      'new_balance': newBalance,
      'streak': streak.toJson(),
      'checked_in_at': checkedInAt.toIso8601String(),
    };
  }

  CheckinResult copyWith({
    int? checkinId,
    Branch? branch,
    double? pointsEarned,
    double? newBalance,
    CheckinStreak? streak,
    DateTime? checkedInAt,
  }) {
    return CheckinResult(
      checkinId: checkinId ?? this.checkinId,
      branch: branch ?? this.branch,
      pointsEarned: pointsEarned ?? this.pointsEarned,
      newBalance: newBalance ?? this.newBalance,
      streak: streak ?? this.streak,
      checkedInAt: checkedInAt ?? this.checkedInAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckinResult &&
          runtimeType == other.runtimeType &&
          checkinId == other.checkinId;

  @override
  int get hashCode => checkinId.hashCode;

  @override
  String toString() =>
      'CheckinResult(checkinId: $checkinId, pointsEarned: $pointsEarned)';
}
