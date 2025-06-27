package dto;

import java.time.LocalDate;
import java.time.LocalTime;

/**
 * 試験・面接情報用のDTOクラス
 */
public class InterviewExamInfoDto {
    private int id;
    private String companyName;
    private String jobTitle;
    private String examType;
    private LocalDate examDate;
    private String examVenue;
    private LocalTime examStartTime;
    private LocalTime examEndTime;
    private LocalDate interviewDate;
    private String interviewVenue;
    private String interviewFormat;
    private String interviewerCount;
    private String examContent;
    private String interviewQuestions;
    private String notes;
    private String createdBy;
    private String createdAt;
    private String updatedAt;

    // コンストラクタ
    public InterviewExamInfoDto() {}

    // ゲッター・セッター
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    public String getExamType() {
        return examType;
    }

    public void setExamType(String examType) {
        this.examType = examType;
    }

    public LocalDate getExamDate() {
        return examDate;
    }

    public void setExamDate(LocalDate examDate) {
        this.examDate = examDate;
    }

    public String getExamVenue() {
        return examVenue;
    }

    public void setExamVenue(String examVenue) {
        this.examVenue = examVenue;
    }

    public LocalTime getExamStartTime() {
        return examStartTime;
    }

    public void setExamStartTime(LocalTime examStartTime) {
        this.examStartTime = examStartTime;
    }

    public LocalTime getExamEndTime() {
        return examEndTime;
    }

    public void setExamEndTime(LocalTime examEndTime) {
        this.examEndTime = examEndTime;
    }

    public LocalDate getInterviewDate() {
        return interviewDate;
    }

    public void setInterviewDate(LocalDate interviewDate) {
        this.interviewDate = interviewDate;
    }

    public String getInterviewVenue() {
        return interviewVenue;
    }

    public void setInterviewVenue(String interviewVenue) {
        this.interviewVenue = interviewVenue;
    }

    public String getInterviewFormat() {
        return interviewFormat;
    }

    public void setInterviewFormat(String interviewFormat) {
        this.interviewFormat = interviewFormat;
    }

    public String getInterviewerCount() {
        return interviewerCount;
    }

    public void setInterviewerCount(String interviewerCount) {
        this.interviewerCount = interviewerCount;
    }

    public String getExamContent() {
        return examContent;
    }

    public void setExamContent(String examContent) {
        this.examContent = examContent;
    }

    public String getInterviewQuestions() {
        return interviewQuestions;
    }

    public void setInterviewQuestions(String interviewQuestions) {
        this.interviewQuestions = interviewQuestions;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }
} 