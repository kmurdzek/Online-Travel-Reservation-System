package com.cs336.pkg;

public class Ticket {
	private int ticket_id;
	private String seat;
	public Ticket(int ticket_id, String seat) {
		this.ticket_id = ticket_id;
		this.seat = seat;
	}
	public int get_ticket_id() {
		return this.ticket_id;
	}
	public String get_seat() {
		return this.seat;
	}
}
