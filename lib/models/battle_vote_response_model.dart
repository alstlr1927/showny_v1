class BattleVoteResponseModel {
  int style1PollCnt;
  int style2PollCnt;

  BattleVoteResponseModel({
    this.style1PollCnt = 0,
    this.style2PollCnt = 0
  });

  factory BattleVoteResponseModel.fromJson(Map<String, dynamic> json) {
    return BattleVoteResponseModel(
      style1PollCnt: int.parse(json['style1PollCnt'] as String),
      style2PollCnt: int.parse(json['style2PollCnt'] as String)
    );
  }
}