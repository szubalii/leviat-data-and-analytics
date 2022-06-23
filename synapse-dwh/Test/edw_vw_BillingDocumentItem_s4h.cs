using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;

namespace Test
{
    [TestClass()]
    public class edw_vw_BillingDocumentItem_s4h : SqlDatabaseTestClass
    {

        public edw_vw_BillingDocumentItem_s4h()
        {
            InitializeComponent();
        }

        [TestInitialize()]
        public void TestInitialize()
        {
            base.InitializeTest();
        }
        [TestCleanup()]
        public void TestCleanup()
        {
            base.CleanupTest();
        }

        #region Designer support code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CurrencyConversion_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(edw_vw_BillingDocumentItem_s4h));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition rowCountCondition1;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction notEmpty_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.NotEmptyResultSetCondition notEmptyResultSetCondition1;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction lgc_InOutIDInIsNotFalse_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition emptyResultSetCondition1;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction sum_BaseAndEDWNetAmountAreEqual_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction cnt_BaseAndEDWAreEqual_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition emptyResultSetCondition2;
            this.CurrencyConversionData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.notEmptyData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.lgc_InOutIDInIsNotFalseData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.sum_BaseAndEDWNetAmountAreEqualData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.cnt_BaseAndEDWAreEqualData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            CurrencyConversion_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            rowCountCondition1 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            notEmpty_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            notEmptyResultSetCondition1 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.NotEmptyResultSetCondition();
            lgc_InOutIDInIsNotFalse_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            emptyResultSetCondition1 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition();
            sum_BaseAndEDWNetAmountAreEqual_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            cnt_BaseAndEDWAreEqual_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            emptyResultSetCondition2 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition();
            // 
            // CurrencyConversion_TestAction
            // 
            CurrencyConversion_TestAction.Conditions.Add(rowCountCondition1);
            resources.ApplyResources(CurrencyConversion_TestAction, "CurrencyConversion_TestAction");
            // 
            // rowCountCondition1
            // 
            rowCountCondition1.Enabled = true;
            rowCountCondition1.Name = "rowCountCondition1";
            rowCountCondition1.ResultSet = 1;
            rowCountCondition1.RowCount = 0;
            // 
            // notEmpty_TestAction
            // 
            notEmpty_TestAction.Conditions.Add(notEmptyResultSetCondition1);
            resources.ApplyResources(notEmpty_TestAction, "notEmpty_TestAction");
            // 
            // notEmptyResultSetCondition1
            // 
            notEmptyResultSetCondition1.Enabled = true;
            notEmptyResultSetCondition1.Name = "notEmptyResultSetCondition1";
            notEmptyResultSetCondition1.ResultSet = 1;
            // 
            // CurrencyConversionData
            // 
            this.CurrencyConversionData.PosttestAction = null;
            this.CurrencyConversionData.PretestAction = null;
            this.CurrencyConversionData.TestAction = CurrencyConversion_TestAction;
            // 
            // notEmptyData
            // 
            this.notEmptyData.PosttestAction = null;
            this.notEmptyData.PretestAction = null;
            this.notEmptyData.TestAction = notEmpty_TestAction;
            // 
            // lgc_InOutIDInIsNotFalseData
            // 
            this.lgc_InOutIDInIsNotFalseData.PosttestAction = null;
            this.lgc_InOutIDInIsNotFalseData.PretestAction = null;
            this.lgc_InOutIDInIsNotFalseData.TestAction = lgc_InOutIDInIsNotFalse_TestAction;
            // 
            // lgc_InOutIDInIsNotFalse_TestAction
            // 
            lgc_InOutIDInIsNotFalse_TestAction.Conditions.Add(emptyResultSetCondition1);
            resources.ApplyResources(lgc_InOutIDInIsNotFalse_TestAction, "lgc_InOutIDInIsNotFalse_TestAction");
            // 
            // emptyResultSetCondition1
            // 
            emptyResultSetCondition1.Enabled = true;
            emptyResultSetCondition1.Name = "emptyResultSetCondition1";
            emptyResultSetCondition1.ResultSet = 1;
            // 
            // sum_BaseAndEDWNetAmountAreEqualData
            // 
            this.sum_BaseAndEDWNetAmountAreEqualData.PosttestAction = null;
            this.sum_BaseAndEDWNetAmountAreEqualData.PretestAction = null;
            this.sum_BaseAndEDWNetAmountAreEqualData.TestAction = sum_BaseAndEDWNetAmountAreEqual_TestAction;
            // 
            // sum_BaseAndEDWNetAmountAreEqual_TestAction
            // 
            resources.ApplyResources(sum_BaseAndEDWNetAmountAreEqual_TestAction, "sum_BaseAndEDWNetAmountAreEqual_TestAction");
            // 
            // cnt_BaseAndEDWAreEqualData
            // 
            this.cnt_BaseAndEDWAreEqualData.PosttestAction = null;
            this.cnt_BaseAndEDWAreEqualData.PretestAction = null;
            this.cnt_BaseAndEDWAreEqualData.TestAction = cnt_BaseAndEDWAreEqual_TestAction;
            // 
            // cnt_BaseAndEDWAreEqual_TestAction
            // 
            cnt_BaseAndEDWAreEqual_TestAction.Conditions.Add(emptyResultSetCondition2);
            resources.ApplyResources(cnt_BaseAndEDWAreEqual_TestAction, "cnt_BaseAndEDWAreEqual_TestAction");
            // 
            // emptyResultSetCondition2
            // 
            emptyResultSetCondition2.Enabled = true;
            emptyResultSetCondition2.Name = "emptyResultSetCondition2";
            emptyResultSetCondition2.ResultSet = 1;
        }

        #endregion


        #region Additional test attributes
        //
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        #endregion

        [TestMethod()]
        public void CurrencyConversion()
        {
            SqlDatabaseTestActions testActions = this.CurrencyConversionData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestMethod()]
        public void notEmpty()
        {
            SqlDatabaseTestActions testActions = this.notEmptyData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestMethod()]
        public void lgc_InOutIDInIsNotFalse()
        {
            SqlDatabaseTestActions testActions = this.lgc_InOutIDInIsNotFalseData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestMethod()]
        public void sum_BaseAndEDWNetAmountAreEqual()
        {
            SqlDatabaseTestActions testActions = this.sum_BaseAndEDWNetAmountAreEqualData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestMethod()]
        public void cnt_BaseAndEDWAreEqual()
        {
            SqlDatabaseTestActions testActions = this.cnt_BaseAndEDWAreEqualData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }




        private SqlDatabaseTestActions CurrencyConversionData;
        private SqlDatabaseTestActions notEmptyData;
        private SqlDatabaseTestActions lgc_InOutIDInIsNotFalseData;
        private SqlDatabaseTestActions sum_BaseAndEDWNetAmountAreEqualData;
        private SqlDatabaseTestActions cnt_BaseAndEDWAreEqualData;
    }
}
