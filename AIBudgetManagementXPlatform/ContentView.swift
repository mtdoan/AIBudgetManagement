//
//  ContentView.swift
//  AIBudgetManagement
//
//  Created by Mindy Doan on 25/10/2023.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    struct HoverableText: View {
        @State var hovered = false;
        var label = "";
        var body: some View {
            Text(label)
                .underline(hovered)
                .animation(.default, value: hovered)
                .onHover(perform: { hovering in
                    self.hovered = hovering
                })
        }
    };
    
    struct HeaderText: View {
        var label = "";
        var body: some View {
            HoverableText(label: label)
                .bold()
                .font(.headline)
                .foregroundStyle(Color.white)
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    };
    
    struct MenuText: View {
        var label = "";
        var body: some View {
            HoverableText(label: label)
                .foregroundStyle(Color.white)
                .padding([.top, .bottom], 8)
                .frame(alignment: .trailing)
        }
    };
    
    struct SectionTitleText: View {
        var label = "";
        var body: some View {
            Text(label)
                .bold()
                .font(.title3)
                .foregroundStyle(Color.blue)
                .padding(8)
                .frame(alignment: .leading)
        }
    };
    
    struct SectionBodyText: View {
        var label = "";
        var body: some View {
            Text(label)
                .padding(2)
                .padding([.leading, .trailing], 8)
                .frame(maxWidth:.infinity, alignment: .leading)
        }
    };
    
    struct BalanceDataPoint: Identifiable {
        var id = UUID();
        var date: Date;
        var balance: Double;
    };
    
    struct BudgetDataPoint : Identifiable {
        var id = UUID();
        var category: String;
        var allocation: Double;
    }
    
    let expenseDataPoints = [
        BalanceDataPoint(date: Date.from(year: 2023, month: 1, day: 1)!, balance: 5000),
        BalanceDataPoint(date: Date.from(year: 2023, month: 2, day: 1)!, balance: 7500),
        BalanceDataPoint(date: Date.from(year: 2023, month: 3, day: 1)!, balance: 10000),
        BalanceDataPoint(date: Date.from(year: 2023, month: 4, day: 1)!, balance: 12500),
        BalanceDataPoint(date: Date.from(year: 2023, month: 5, day: 1)!, balance: 15000),
        BalanceDataPoint(date: Date.from(year: 2023, month: 6, day: 1)!, balance: 17500),
        BalanceDataPoint(date: Date.from(year: 2023, month: 7, day: 1)!, balance: 20000),
        BalanceDataPoint(date: Date.from(year: 2023, month: 8, day: 1)!, balance: 22500),
        BalanceDataPoint(date: Date.from(year: 2023, month: 9, day: 1)!, balance: 25000)
    ];
    let incomeDataPoints = [
        BalanceDataPoint(date: Date.from(year: 2023, month: 1, day: 1)!, balance: 10000),
        BalanceDataPoint(date: Date.from(year: 2023, month: 2, day: 1)!, balance: 20000),
        BalanceDataPoint(date: Date.from(year: 2023, month: 3, day: 1)!, balance: 30000),
        BalanceDataPoint(date: Date.from(year: 2023, month: 4, day: 1)!, balance: 40000),
        BalanceDataPoint(date: Date.from(year: 2023, month: 5, day: 1)!, balance: 50000),
        BalanceDataPoint(date: Date.from(year: 2023, month: 6, day: 1)!, balance: 60000),
        BalanceDataPoint(date: Date.from(year: 2023, month: 7, day: 1)!, balance: 70000),
        BalanceDataPoint(date: Date.from(year: 2023, month: 8, day: 1)!, balance: 80000),
        BalanceDataPoint(date: Date.from(year: 2023, month: 9, day: 1)!, balance: 90000)
    ];
    let budgets = [
        BudgetDataPoint(category: "Housing", allocation: 0.5),
        BudgetDataPoint(category: "Transport", allocation: 0.25),
        BudgetDataPoint(category: "Food", allocation: 0.25)
    ];
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                HeaderText(label: "AI Budget Tracker")
                
                MenuText(label: "Dashboard")
                MenuText(label: "Expenses")
                MenuText(label: "Budgeting & Goals")
                MenuText(label: "Analysis & Recommendations")
                    .padding([.trailing], 8)
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
            .background(Color.blue.gradient)

            HStack (alignment: .top) {
                VStack {
                    SectionTitleText(label: "Overview")
                    SectionBodyText(label: "Current Balance").bold()
                    SectionBodyText(label: "$10,000")
                    SectionBodyText(label: "Total Income").bold()
                    SectionBodyText(label: "$20,000")
                    SectionBodyText(label: "Total Expenses").bold()
                    SectionBodyText(label: "$10,000")
                    SectionBodyText(label: "Savings").bold()
                    SectionBodyText(label: "$5,000")
                    Chart {
                        ForEach(incomeDataPoints) { point in
                            LineMark(
                                x: .value("Date", point.date),
                                y: .value("Amount", point.balance),
                                series: .value("Income", "Income")
                            )
                            .foregroundStyle(.green)
                        }
                        
                        
                        ForEach(expenseDataPoints) { point in
                            LineMark(
                                x: .value("Date", point.date),
                                y: .value("Amount", point.balance),
                                series: .value("Expense", "Expense")
                            )
                            .foregroundStyle(.red)
                        }
                        
                    }
                    .tableColumnHeaders(Visibility.visible)
                    .chartForegroundStyleScale(["Income": Color.green, "Expense": Color.red])
                    .chartLegend(Visibility.visible)
                    .chartLegend(position: .top, alignment: .center)
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .frame(maxWidth: .infinity, minHeight: 200)
                    .padding(8)
                    
                }
                .border(Color.primary, width: 1)
                VStack {
                    SectionTitleText(label: "Budgeting")
                    VStack {
                        ForEach(budgets) { budget in
                            HStack {
                                SectionBodyText(label: budget.category)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                ProgressView(value: budget.allocation) {
                                    SectionBodyText(
                                        label: String(format: "%3.1f%%", budget.allocation * 100))
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                }
                                .frame(width: 80, alignment: .trailing)
                                .padding([.trailing], 8)
                            }
                        }
                    }
                    .border(Color.primary, width: 1)
                    .padding([.leading, .trailing], 8)
                    Button(action: {}) {                        Text("Add Category")
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .border(Color.primary, width: 1)
            }
            .padding(16)
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
};

extension Date {
    /// Create a date from specified parameters
    ///
    /// - Parameters:
    ///   - year: The desired year
    ///   - month: The desired month
    ///   - day: The desired day
    /// - Returns: A `Date` object
    static func from(year: Int, month: Int, day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
};

#Preview {
    ContentView()
}
