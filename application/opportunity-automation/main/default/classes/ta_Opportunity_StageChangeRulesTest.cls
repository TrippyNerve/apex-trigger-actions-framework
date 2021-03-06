/*
   Copyright 2020 Google LLC

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
 */

@IsTest
private class ta_Opportunity_StageChangeRulesTest {
	
	@IsTest
	private static void beforeUpdate_test() {
		List<Opportunity> newList = new List<Opportunity>();
		List<Opportunity> oldList = new List<Opportunity>();
		Id myRecordId = TestUtility.getFakeId(Opportunity.SObjectType);
		newList.add(new Opportunity(Id = myRecordId, StageName = Constants.OPPORTUNITY_STAGENAME_CLOSED_WON));
		oldList.add(new Opportunity(Id = myRecordId, StageName = Constants.OPPORTUNITY_STAGENAME_QUALIFICATION));
		Test.startTest();
		new ta_Opportunity_StageChangeRules().beforeUpdate(newList, oldList);
		Test.stopTest();
		//Use Apex Pages Messages to get errors from AddError without performing DML
		System.assertEquals(true, ApexPages.hasMessages());
		System.assertEquals(1, ApexPages.getMessages().size());
		System.assertEquals(true, ApexPages.getMessages()[0].getDetail().contains(String.format(ta_Opportunity_StageChangeRules.INVALID_STAGE_CHANGE_ERROR, new String[] {Constants.OPPORTUNITY_STAGENAME_QUALIFICATION, Constants.OPPORTUNITY_STAGENAME_CLOSED_WON})));
	}
}

